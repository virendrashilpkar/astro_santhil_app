import 'package:astro_santhil_app/models/slot_view_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:flutter/material.dart';

class CategoryManagement extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CategoryManagement();
}

class _CategoryManagement extends State<CategoryManagement>{

  DateTime? date;
  String dob = "";
  late ViewSlotModel _viewSlotModel;
  List<Body> _list = [];
  bool _pageLoading = false;

  void slots() async {
    _pageLoading = true;
    if(dob != "Select Date"){
      dob = dob;
    }else{
      dob = "";
    }
    _viewSlotModel = await Services.SlotView(dob);
    if(_viewSlotModel.status == true){
      for(var i = 0; i < _viewSlotModel.body!.length; i++){
        _list = _viewSlotModel.body ?? <Body> [];
      }
    }
    setState(() {
      _pageLoading = false;
    });
  }

  @override
  void initState() {
    slots();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xFF009688),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                )
            ),
            child: Container(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Menu("Slots")));
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
                      "SLOTS",
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
          ),
          SizedBox(height: 30.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: InkWell(
              onTap: () async {
                date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(5000),
                  builder: (BuildContext context, Widget? child){
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          surface: Colors.white,
                          onSurface: Colors.black,
                        ),
                        dialogBackgroundColor:Colors.white,
                      ),
                      child: child!,
                    );
                  },
                );
                int? month = date?.month;
                String? fm = "" + "${month}";
                String? fd = "" + "${date?.day}";
                if (month! < 10) {
                  fm = "0" + "${month}";
                  print("fm ${fm}");
                }
                if (date!.day < 10) {
                  fd = "0" + "${date?.day}";
                  print("fd ${fd}");
                }
                if (date != null) {
                  print(
                      'Date Selecte : ${date?.day ?? ""}-${date?.month ?? ""}-${date?.year ?? ""}');
                  setState(() {
                    dob =
                    '${date?.year ?? ""}-${fm}-${fd}';
                    print(
                        "selectedFromDate ${dob?.split(" ")[0]}");
                  });
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin:
                EdgeInsets.only(right: 10.0),
                padding: EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    right: 10.0,
                    bottom: 10.0),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: Color(0xFFD0D4E0)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Row(
                  children: [
                    dob.isEmpty ?Text(
                      "Select Date",
                      style: TextStyle(
                        color: Color(0xff6C7480),
                      ),
                    ): Text(
                      "${dob}",
                      style: TextStyle(
                        color: Color(0xff6C7480),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.calendar_month,
                      color: Color(0xff6C7480),
                    )
                  ],
                )
              ),
            ),
          ),
          Expanded(
            child: _pageLoading ? Center(
              child: CircularProgressIndicator(),
            ) : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                itemCount: _list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0
                  ), itemBuilder: (context, index){
                  Body _body = _list[index];
                final fromTime =
                _body.fromTime!.substring(0,2).contains("13") ? "01${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("14") ? "02${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("15") ? "03${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("16") ? "04${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("17") ? "05${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("18") ? "06${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("19") ? "07${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("20") ? "08${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("21") ? "09${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("22") ? "10${_body.fromTime!.substring(2,5)} PM":
                _body.fromTime!.substring(0,2).contains("23") ? "11${_body.fromTime!.substring(2,5)} PM":
                "${_body.fromTime!.substring(0,5)} AM";

                final toTime =
                _body.toTime!.substring(0,2).contains("13") ? "01${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("14") ? "02${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("15") ? "03${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("16") ? "04${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("17") ? "05${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("18") ? "06${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("19") ? "07${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("20") ? "08${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("21") ? "09${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("22") ? "10${_body.toTime!.substring(2,5)} PM":
                _body.toTime!.substring(0,2).contains("23") ? "11${_body.toTime!.substring(2,5)} PM":
                "${_body.toTime!.substring(0,5)} AM";

                    return InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        decoration:  BoxDecoration(
                          color: _body.bookStatus == "1" ? Colors.grey[400] : Colors.white,
                          border: Border.all(
                            color: Colors.grey
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${fromTime} - ${toTime}",
                            style: TextStyle(
                              fontSize: 10,
                              color: _body.bookStatus == "1" ? Colors.black38 : Colors.black,
                            ),),
                            SizedBox(width: 5,),
                            Image.asset("assets/edit_ic.png",
                              color: _body.bookStatus == "1" ? Colors.black38 : Colors.black,
                              height: 15,),
                        SizedBox(width: 5,),
                        Image.asset("assets/delete_ic.png",
                          color: _body.bookStatus == "1" ? Colors.black38 : Colors.black,
                          height: 15,)
                          ],
                        ),
                      ),
                    );
              }),
            ),
          )
        ],
      )
    );
  }

}