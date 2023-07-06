import 'dart:math';

import 'package:astro_santhil_app/models/add_appointment_model.dart';
import 'package:astro_santhil_app/models/appointment_detai_model.dart';
import 'package:astro_santhil_app/models/customer_name_model.dart';
import 'package:astro_santhil_app/models/update_appointment_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/appointment.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:table_calendar/table_calendar.dart';

class EditAppointment extends StatefulWidget {
  String id = "";

  EditAppointment(this.id);

  @override
  State<StatefulWidget> createState() => _EditAppointmentState();

}

class _EditAppointmentState extends State<EditAppointment> {

  TextEditingController fees = TextEditingController();
  TextEditingController msg = TextEditingController();

  late CustomerNameModel _customerNameModel;
  late AddAppointmentModel _addAppointmentModel;
  late UpdateAppointmentModel _updateAppointmentModel;
  late AppointmentDetailModel _detailModel;
  DateTime today = DateTime.now();
  PageController? _pageController;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked;
  int _radioSelected = 0;
  String _radioVal = "";
  String feesStatus = "";
  List<String> customer_id = ["0",];
  String selectedCustomer_id = "";
  String selectTimes = "Select Slot";
  String dropdownValue = 'Select Customer';
  bool isLoad = false;

  List <String> spinnerItems = [
    'Select Customer',
  ] ;

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
        }
    );
    if(picked != null){
      setState(() {
        _time = picked!;
        print(picked);
        selectTimes = "${picked?.hour}:${picked?.minute}:${picked?.period.name.toUpperCase()}";
      });
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
      print(today);
    });
  }

  Future<void> viewDropDown() async {
    _customerNameModel = await Services.nameListApi();
    if(_customerNameModel.status == true){
      for(var i=0; i < _customerNameModel.body!.length; i++){
        spinnerItems.add("${_customerNameModel.body![i].name}");
        customer_id.add(_customerNameModel.body![i].userId.toString());
      }
      print(spinnerItems);
    }else{
      Fluttertoast.showToast(
          msg: "not found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {

    });
  }

  Future<void> updateAppointment() async {
    _updateAppointmentModel = await Services.updateAppointment(widget.id, today.toString().substring(0,10),
        selectTimes, msg.text, fees.text, _radioSelected.toString());

    if(_updateAppointmentModel.status == true){
      Fluttertoast.showToast(msg: "${_updateAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Appointment("today")));
    }else{
      Fluttertoast.showToast(msg: "${_updateAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
  }

  Future<void> appointmentDetail() async {
    isLoad = true;
    _detailModel = await Services.appointmentDetail(widget.id);
    if(_detailModel.status == true){
      dropdownValue = "${_detailModel.body![0].name} (${_detailModel.body![0].phone})";
      today = DateTime.parse(_detailModel.body![0].date.toString());
      selectTimes = _detailModel.body![0].time.toString();
      fees.text = _detailModel.body![0].fees.toString();
      _radioSelected = int.parse(_detailModel.body![0].feesStatus.toString());
      msg.text = _detailModel.body![0].message.toString();
    }
    isLoad = false;
    setState(() {

    });

  }
  @override
  void initState() {
    super.initState();
    viewDropDown();
    appointmentDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoad ? Center(
        child: CircularProgressIndicator(),
      ): Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff1BBF57),
                Color(0xff34E389),
              ],)
        ),
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
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Menu()));
                        },
                        child: Container(
                          child: Image.asset("assets/drawer_ic.png",
                            width: 22.51,
                            height: 20.58,),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Text("Edit Appointment", style: TextStyle(color: Colors.white, fontSize: 21.61),),
                      ),
                      Spacer(),
                      Container(
                        child: InkWell(
                          onTap: (){
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
                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("assets/back_arrow_ic.png",
                                color: Colors.black,),
                            ),
                            Spacer(),
                            Image.asset("assets/send_ic.png",
                              color: Colors.black,),
                            SizedBox(width: 10.0,),
                            Image.asset("assets/fav_ic.png",
                              color: Colors.black,)
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff6C7480)
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)
                                    )
                                ),
                                child: DropdownButton<String>(
                                  value: dropdownValue,
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down_sharp),
                                  iconSize: 20,
                                  elevation: 16,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  underline: Container(
                                    height: 0,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? data) {
                                    setState(() {
                                      dropdownValue = data!;
                                      if(dropdownValue != "Select Customer"){
                                        for(var i = 0; i < spinnerItems.length; i++){
                                          if(spinnerItems[i] == dropdownValue){
                                            selectedCustomer_id = customer_id[i];
                                          }
                                        }
                                        print("fghfdsasdfghgfdsasdfghgfdsaASDFG  "+selectedCustomer_id);
                                      }
                                    });
                                  },
                                  items: spinnerItems
                                      .map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value)
                                    );
                                  }).toList(),
                                )
                            ),
                            Row(
                              children: [
                                Text("General Practitioner", style: TextStyle(fontSize: 16.82, color: Color(0xffB2B9C4)),),
                                Spacer(),
                                Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    child: Text("See All Reviews",
                                      style: TextStyle(fontSize: 12.62, color: Color(0xffB2B9C4)),))
                              ],
                            )
                          ],
                        ),
                      ),
                      TableCalendar(
                        focusedDay: today,
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2050,10,16),
                        onCalendarCreated: (controller) => _pageController = controller,
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) =>isSameDay(day, today),
                        availableGestures: AvailableGestures.all,
                        headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white,),
                            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white,),
                            titleTextStyle: TextStyle(fontSize: 25.24, color: Colors.white),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("assets/calender_bg.png"))
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("SELECT TIME"),
                      ),
                      InkWell(
                        onTap: (){
                          selectTime(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff6C7480)
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                          ),
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                        margin: EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Fees"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff6C7480)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0,),
                        child: TextField(
                            controller: fees,
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: 'Fees',
                              hintStyle: const TextStyle(
                                fontSize: 14.0,
                                color: Color(0xff6C7480),
                              ),
                              border: InputBorder.none,
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Fees Type"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Radio(
                              activeColor: Colors.greenAccent,
                              value: 1,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState((){
                                  _radioSelected = value as int;
                                  _radioVal = 'Paid';
                                  print(_radioVal);
                                });
                              },
                            ),
                            Text('Paid'),
                            Radio(
                              activeColor: Colors.greenAccent,
                              value: 2,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState((){
                                  _radioSelected = value as int;
                                  _radioVal = 'UnPaid';
                                  print(_radioVal);
                                });
                              },
                            ),
                            Text('Un Paid'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30.0, top: 20.0, bottom: 5.0),
                        child: Text("Messages"),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff6C7480)
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                        ),
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
                            )
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 20.0, right:20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                updateAppointment();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width/2.4,
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                alignment: Alignment.center,
                                height: 60,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff1BBF57).withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 10), // changes position of shadow
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'update'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(width: 10.0,),
                            // Container(
                            //   width: MediaQuery.of(context).size.width/2.4,
                            //   height: 60,
                            //   alignment: Alignment.center,
                            //   margin: EdgeInsets.only(left: 10.0),
                            //   decoration: BoxDecoration(
                            //       border: Border.all(
                            //           color: Color(0xffFF663D)
                            //       ),
                            //       borderRadius: BorderRadius.all(
                            //           Radius.circular(5.0)
                            //       )
                            //   ),
                            //   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                            //   child: Text("CANCEL"),
                            // )
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