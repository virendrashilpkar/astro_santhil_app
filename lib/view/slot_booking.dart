import 'package:astro_santhil_app/commonpackage/SearchChoices.dart';
import 'package:astro_santhil_app/models/add_appointment_model.dart';
import 'package:astro_santhil_app/models/customer_name_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/add_appointment.dart';
import 'package:astro_santhil_app/view/appointment.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

class SlotBooking extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SlotBookingState();
}

class _SlotBookingState extends State<SlotBooking> {
  TextEditingController fees = TextEditingController();
  TextEditingController msg = TextEditingController();
  List<DropdownMenuItem> cutomerItems = [];
  List<Contact> contacts = [];
  List<Contact> foundContacts = [];
  bool isLoading = false;

  late CustomerNameModel _customerNameModel;
  late AddAppointmentModel _addAppointmentModel;
  DateTime today = DateTime.now();
  PageController? _pageController;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked;
  int _radioSelected = 0;
  String _radioVal = "";
  String feesStatus = "";
  List<String> customer_id = [
    "0",
  ];
  String selectedCustomer_id = "";
  String selectTimes = "Select Time";
  String dropdownValue = "";
  bool clickLoad = false;

  List<String> spinnerItems = [
    'Select Customer',
  ];

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
        context: context,
        initialTime: _time,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        _time = picked!;
        print(picked);
        selectTimes =
            "${picked?.hour}:${picked?.minute}:${picked?.period.name.toUpperCase()}";
      });
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
      print(today);
    });
  }

  Future<void> viewDropDown() async {
    _customerNameModel = await Services.nameListApi();
    if (_customerNameModel.status == true) {
      for (var i = 0; i < _customerNameModel.body!.length; i++) {
        spinnerItems.add("${_customerNameModel.body![i].name}");
        cutomerItems.add(DropdownMenuItem(
          child: Text(_customerNameModel.body![i].name.toString()),
          value: _customerNameModel.body![i].name.toString(),
        ));
        customer_id.add(_customerNameModel.body![i].userId.toString());
      }
    } else {
      Fluttertoast.showToast(
          msg: "not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {});
  }

  Future<void> addAppointment() async {
    setState(() {
      clickLoad = true;
    });
    _addAppointmentModel = await Services.addAppointment(
        selectedCustomer_id,
        today.toString().substring(0, 10),
        selectTimes,
        msg.text,
        fees.text,
        _radioSelected.toString());

    if (_addAppointmentModel.status == true) {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Appointment("today")));
    } else {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {
      clickLoad = false;
    });
  }

  void getContactPermission() async {

    if(await Permission.contacts.isGranted) {
      getContacts();
    }else {
      await Permission.contacts.request();
    }
  }

  void getContacts() async {
    setState(() {
      isLoading = true;
    });
   contacts = await ContactsService.getContacts();
   print(contacts[0].phones![0].value);

   foundContacts = contacts;
   print(foundContacts);
   setState(() {
     isLoading = false;
   });
  }


  // void contactList(){
  //   showBottomSheet(
  //       context: context,
  //       backgroundColor: Colors.white,
  //       elevation: 10,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       builder: (context) {
  //         return StatefulBuilder(
  //             builder: (BuildContext context, StateSetter setState){
  //               return ListView.builder(
  //                 itemCount: contacts.length,
  //                   itemBuilder: (context, index){
  //                   return ListTile(
  //                     leading: Text(contacts[index].displayName.toString()),
  //                   );
  //                   });
  //             }
  //         );
  //       }
  //   );
  // }

  @override
  void initState() {
    super.initState();
    viewDropDown();

  }

  void searchFilter(String enteredKeyword, StateSetter dState) {
    List<Contact> results = [];
    if(enteredKeyword.isEmpty){
      results = contacts;
    }else{
      results = contacts
          .where((element) =>
          element.givenName!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    dState(() {
      foundContacts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xff1BBF57),
            Color(0xff34E389),
          ],
        )),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Menu()));
                        },
                        child: Container(
                          child: Image.asset(
                            "assets/drawer_ic.png",
                            width: 22.51,
                            height: 20.58,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Text(
                          "SLOT BOOKING",
                          style:
                              TextStyle(color: Colors.white, fontSize: 21.61),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.13),
                  color: Colors.white,
                  // height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Container(
                      //   margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                      //   child: Row(
                      //     children: [
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: Image.asset("assets/back_arrow_ic.png",
                      //         color: Colors.black,),
                      //       ),
                      //       Spacer(),
                      //       Image.asset("assets/send_ic.png",
                      //       color: Colors.black,),
                      //       SizedBox(width: 10.0,),
                      //       Image.asset("assets/fav_ic.png",
                      //       color: Colors.black,)
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10.0, right: 10.0),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Color(0xff6C7480)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      child: SearchChoices.single(
                                        value: dropdownValue,
                                        items: cutomerItems,
                                        hint: "Select Customer",
                                        searchHint: "Select Customer",
                                        style: TextStyle(color: Colors.black),
                                        underline: Container(),
                                        onChanged: (value) {
                                          setState(() {
                                            dropdownValue = value;
                                            if (dropdownValue != "Select Customer") {
                                              for (var i = 0;
                                                  i < spinnerItems.length;
                                                  i++) {
                                                if (spinnerItems[i] ==
                                                    dropdownValue) {
                                                  selectedCustomer_id =
                                                      customer_id[i];
                                                }
                                              }
                                              print(
                                                  "fghfdsasdfghgfdsasdfghgfdsaASDFG  " +
                                                      selectedCustomer_id);
                                            }
                                          });
                                        },
                                        displayClearIcon: false,
                                        isExpanded: true,
                                      )
                                      // DropdownButton<String>(
                                      //         value: dropdownValue,
                                      //         isExpanded: true,
                                      //         icon: Icon(Icons.keyboard_arrow_down_sharp),
                                      //         iconSize: 20,
                                      //         elevation: 16,
                                      //         style: const TextStyle(
                                      //             color: Colors.black,
                                      //             fontSize: 16,
                                      //             fontWeight: FontWeight.w400),
                                      //         underline: Container(
                                      //             height: 0,
                                      //             color: Colors.deepPurpleAccent,
                                      //           ),
                                      //         onChanged: (String? data) {
                                      //           setState(() {
                                      //             dropdownValue = data!;
                                      //             if(dropdownValue != "Select Customer"){
                                      //               for(var i = 0; i < spinnerItems.length; i++){
                                      //                 if(spinnerItems[i] == dropdownValue){
                                      //                   selectedCustomer_id = customer_id[i];
                                      //                 }
                                      //               }
                                      //               print("fghfdsasdfghgfdsasdfghgfdsaASDFG  "+selectedCustomer_id);
                                      //             }
                                      //           });
                                      //         },
                                      //         items: spinnerItems
                                      //             .map<DropdownMenuItem<String>>((String value){
                                      //               return DropdownMenuItem(
                                      //                 value: value,
                                      //                   child: Text(value)
                                      //               );
                                      //         }).toList(),
                                      //       )
                                      ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Text("General Practitioner", style: TextStyle(fontSize: 16.82, color: Color(0xffB2B9C4)),),
                            //     Spacer(),
                            //     Container(
                            //       margin: EdgeInsets.only(top: 10.0),
                            //         child: Text("See All Reviews",
                            //           style: TextStyle(fontSize: 12.62, color: Color(0xffB2B9C4)),))
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      TableCalendar(
                        focusedDay: today,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2050, 10, 16),
                        onCalendarCreated: (controller) =>
                            _pageController = controller,
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        availableGestures: AvailableGestures.all,
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                            titleTextStyle:
                                TextStyle(fontSize: 25.24, color: Colors.white),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/calender_bg.png")))),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("SELECT TIME"),
                      ),
                      InkWell(
                        onTap: () {
                          selectTime(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff6C7480)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            children: [
                              Text(selectTimes),
                              Spacer(),
                              Icon(Icons.keyboard_arrow_down)
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Fees"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff6C7480)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: TextField(
                            controller: fees,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Fees',
                              prefixText: "\u{20B9}",
                              prefixStyle: TextStyle(color: Colors.black),
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff6C7480),
                              ),
                              border: InputBorder.none,
                            )),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Fees Type"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor: Colors.greenAccent,
                              value: 2,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState(() {
                                  _radioSelected = value as int;
                                  _radioVal = 'Paid';
                                  print(_radioVal);
                                });
                              },
                            ),
                            Text('Paid'),
                            Radio(
                              activeColor: Colors.greenAccent,
                              value: 1,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState(() {
                                  _radioSelected = value as int;
                                  _radioVal = 'UnPaid';
                                  print(_radioVal);
                                });
                              },
                            ),
                            Text('UnPaid'),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Message"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff6C7480)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0))),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                            controller: msg,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Message',
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff6C7480),
                              ),
                              border: InputBorder.none,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (dropdownValue == "Select Customer") {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Customer",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR);
                                } else if (selectTimes == "Select Time") {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Time",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR);
                                } else if (fees.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Fees",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR);
                                } else if (_radioSelected == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Please Select Fess Type",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR);
                                } else if (msg.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please Enter Message",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.SNACKBAR);
                                } else {
                                  addAppointment();
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff1BBF57).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 10), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff1BBF57),
                                        Color(0xff34E389)
                                      ],
                                      begin: const FractionalOffset(1.0, 0.0),
                                      end: const FractionalOffset(0.0, 0.0),
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.clamp),
                                ),
                                child: clickLoad
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 3.0,
                                            ),
                                          )
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Make an\nappointment'
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                height: 60,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 10.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffFF663D)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5.0),
                                child: Text("CANCEL"),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MYBottomSheet extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<MYBottomSheet>{

  List<Contact> contacts = [];
  List<Contact> foundContacts = [];
  bool isLoading = false;

  void getContactPermission() async {

    if(await Permission.contacts.isGranted) {
      getContacts();
    }else {
      await Permission.contacts.request();
    }
  }

  void getContacts() async {
    setState(() {
      isLoading = true;
    });
    contacts = await ContactsService.getContacts();
    print(contacts[0].phones![0].value);

    foundContacts = contacts;
    print(foundContacts);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  void searchFilter(String enteredKeyword, StateSetter dState) {
    List<Contact> results = [];
    if(enteredKeyword.isEmpty){
      results = contacts;
    }else{
      results = contacts
          .where((element) =>
          element.givenName!.toLowerCase().contains(enteredKeyword.toLowerCase()) ||
              element.phones![0].value!.contains(enteredKeyword)).toList();
    }
    dState(() {
      foundContacts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            return isLoading ? Center(
              child: CircularProgressIndicator(),
            ):Container(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_rounded)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xff6C7480)),
                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0))),
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      child: TextField(
                        // controller: fees,
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search Contact',
                          prefixStyle: TextStyle(color: Colors.black),
                          hintStyle: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff6C7480),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => searchFilter(value, setState),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: foundContacts.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            return InkWell(
                              onTap: (){
                                setState((){
                                  // dropdownValue = foundContacts[index].displayName.toString();
                                });
                                // cutomerItems.add(DropdownMenuItem(
                                //   child: Text(foundContacts[index].displayName.toString()),
                                //   value: foundContacts[index].displayName.toString(),
                                // ));
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                    AddAppointment(foundContacts[index].displayName.toString(), foundContacts[index].phones![0].value.toString())));
                              },
                              child: ListTile(
                                leading: Container(
                                  height: 30,
                                  width: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 7,
                                            color: Colors.white.withOpacity(0.1),
                                            offset: Offset(-3, -3)
                                        ),
                                        BoxShadow(
                                            blurRadius: 7,
                                            color: Colors.black.withOpacity(0.1),
                                            offset: Offset(3, -3)
                                        )
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(6.0)
                                      ),
                                      color: Color(0xff262626)
                                  ),
                                  child: Text(
                                    "${foundContacts[index].givenName?.substring(0,1).toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "${foundContacts[index].displayName}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                subtitle: Text(
                                  "${foundContacts[index].phones![0].value}",
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                horizontalTitleGap: 12,
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

}