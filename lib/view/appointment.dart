import 'dart:math';

import 'package:astro_santhil_app/models/appointment_view_model.dart';
import 'package:astro_santhil_app/models/complete_appointment_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/models/cancel_appointment_model.dart';
import 'package:astro_santhil_app/view/edit_appointment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'menu.dart';

class Appointment extends StatefulWidget {

  String tabValue = "";

  Appointment(this.tabValue);

  @override
  State<StatefulWidget> createState() => _AppointmentState();

}

class _AppointmentState extends State<Appointment> {

  late AppointmentViewModel _appointmentViewModel;
  late CancelAppointmentModel _cancelAppointmentModel;
  late CompleteAppointmentModel _completeAppointmentModel;
  List<Body> _list = [];
  bool _pageLoading = false;
  List<Color> gradientColorList = [
    Color(0xff1C3B70),
    Color(0xff019AD6),
    Color(0xff1C5870),
    Color(0xffFF9900),
    Color(0xffFF3D3D),
  ];

  List<Color> gradientColorListLight = [
    Color(0xff006093),
    Color(0xff30D4FD),
    Color(0xff009393),
    Color(0xffFFBF00),
    Color(0xffFF663D),
  ];

  final _random = Random();
  String tab = "";
  int _radioSelected = 0;
  String _radioVal = "";

  Future<void> viewAppointment(String type) async {
    _pageLoading = true;
    _list.clear();
    _appointmentViewModel = await Services.appointmentView(type);
    if(_appointmentViewModel.status == true){
      for(var i = 0; i < _appointmentViewModel.body!.length; i++){
        _list = _appointmentViewModel.body ?? <Body> [];
      }
    }
    setState(() {
      
    });
    _pageLoading = false;
  }

  Future<void> deleteAppointment(String id) async {
    _cancelAppointmentModel = await Services.cancelAppointment(id);
    if(_cancelAppointmentModel.status == true){
      Fluttertoast.showToast(msg: "${_cancelAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      viewAppointment(tab);
      Navigator.pop(context);
    }else {
          Fluttertoast.showToast(msg: "${_cancelAppointmentModel.msg}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR);
    }
    setState(() {

    });
  }

  void updateStatus(String id) async {
    _completeAppointmentModel = await Services.completeAppointment(id);
    if(_completeAppointmentModel.status == true){
      Fluttertoast.showToast(msg: "${_completeAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      viewAppointment(tab);
      Navigator.pop(context);
    }else {
      Fluttertoast.showToast(msg: "${_completeAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {

    });
  }

  void deleteDailog(String id) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Are you sure you want to delete this appointment?", style: TextStyle(
            fontWeight: FontWeight.w600, fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                onPressed: (){
                 deleteAppointment(id);
                },
                child: Text("Yes", style: TextStyle(fontSize: 16.0),)
            ),
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("No", style: TextStyle(fontSize: 16.0),)
            )
          ]
      ),
    );
  }

  void updateStatusDailog(String id) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context){
        return StatefulBuilder(
            builder: (context, setState){
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Appointment Status", style: TextStyle(
                          fontSize: 18.0,
                        ),),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState((){
                                  _radioSelected = value as int;
                                  _radioVal = 'Cancel';
                                  print(_radioVal);
                                });
                              }
                          ),
                          Text("Cancel")
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: _radioSelected,
                              onChanged: (value) {
                                setState((){
                                  _radioSelected = value as int;
                                  _radioVal = 'Complete';
                                  print(_radioVal);
                                });
                              }
                          ),
                          Text("Complete")
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 20.0,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: (){
                                  if(_radioSelected == 1){
                                    deleteAppointment(id);
                                  }else if(_radioSelected == 2){
                                    updateStatus(id);
                                  }
                                },
                                child: Text("Yes")
                            ),
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("No")
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                )
              );
            });
      }
    );
  }

  @override
  void initState() {
    tab = widget.tabValue;
    viewAppointment(tab);
    super.initState();
  }

  void onClick(String value){
    setState(() {
      tab = value;
      viewAppointment(tab);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
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
                  physics: NeverScrollableScrollPhysics(),
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
                              child: Text("APPOINMENTS", style: TextStyle(color: Colors.white, fontSize: 21.61),),
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
                      SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: (){
                              onClick("today");
                            },
                            child: Container(
                              decoration: tab.matchAsPrefix("today") != null?BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff019AD6),
                                        Color(0xff30D4FD)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  border: Border.all(color: Colors.black,
                                      width: 1.0),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ):BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff019AD6),
                                        Color(0xff30D4FD)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13.3, vertical: 9.0),
                              child: Text("today".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 9.17),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              onClick("pending");
                            },
                            child: Container(
                              decoration: tab.matchAsPrefix("pending") != null?BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFF663D),
                                        Color(0xffFF3D3D)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  border: Border.all(color: Colors.black,
                                      width: 1.0),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ):BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFF663D),
                                        Color(0xffFF3D3D)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13.3, vertical: 9.0),
                              child: Text("Pending".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 9.17),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              onClick("cancel");
                            },
                            child: Container(
                              decoration: tab.matchAsPrefix("cancel") != null?BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFFBF00),
                                        Color(0xffFF9900)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  border: Border.all(color: Colors.black,
                                      width: 1.0),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ):BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFFBF00),
                                        Color(0xffFF9900)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13.3, vertical: 9.0),
                              child: Text("Cancel".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 9.17),),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              onClick("completed");
                            },
                            child: Container(
                              decoration: tab.matchAsPrefix("completed") != null ? BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff009393),
                                        Color(0xff1C5870)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.centerRight
                                  ),
                                  border: Border.all(color: Colors.black,
                                      width: 1.0),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ): BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        Color(0xff009393),
                                        Color(0xff1C5870)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter
                                  ),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)
                                  )
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13.3, vertical: 9.0),
                              child: Text("Completed".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 9.17),),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 20.0),
                        color: Colors.white,
                        height: MediaQuery.of(context).size.height,
                        child: _pageLoading? Center(
                          child: CircularProgressIndicator(),
                        ): _appointmentViewModel.status == false ?Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: Text("Appointment not available".toUpperCase(),
                              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                          ),
                        ):tab.matchAsPrefix("today") != null ?
                        ListView.builder(
                            itemCount: _list.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              Body _body = _list[index];
                              int randomNumber = _random.nextInt(5);
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  child: Card(
                                      color: Colors.white,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)
                                          )
                                      ),
                                      elevation: 10.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)
                                            )
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              gradientColorList[randomNumber],
                                                              gradientColorListLight[randomNumber],
                                                            ],
                                                            begin: const FractionalOffset(0.0, 0.0),
                                                            end: const FractionalOffset(0.0, 1.0),
                                                            stops: [0.0, 1.0],
                                                            tileMode: TileMode.clamp
                                                        )
                                                    ),
                                                    child: Image.asset("assets/user_ic_white.png"),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_body.name.toString()),
                                                        Row(
                                                          children: [
                                                            Text("Payment Status"),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text("(${_body.date.toString().substring(0,10)})"),
                                                        Text("(${_body.time})")
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        updateStatusDailog(_body.id.toString());
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/status_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Status", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context) => EditAppointment(_body.id.toString())));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/edit_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Edit", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        deleteDailog(_body.id.toString());
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/delete_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Delete", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xfff5f5f5),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)
                                                          )
                                                      ),
                                                      child: Image.asset("assets/phone_ic.png",
                                                        color: Colors.green,),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                              );
                            }):
                        tab.matchAsPrefix("pending") != null ?ListView.builder(
                            itemCount: _list.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              Body _body = _list[index];
                              int randomNumber = _random.nextInt(5);
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  child: Card(
                                      color: Colors.white,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)
                                          )
                                      ),
                                      elevation: 10.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)
                                            )
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              gradientColorList[randomNumber],
                                                              gradientColorListLight[randomNumber],
                                                            ],
                                                            begin: const FractionalOffset(0.0, 0.0),
                                                            end: const FractionalOffset(0.0, 1.0),
                                                            stops: [0.0, 1.0],
                                                            tileMode: TileMode.clamp
                                                        )
                                                    ),
                                                    child: Image.asset("assets/user_ic_white.png"),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_body.name.toString()),
                                                        Row(
                                                          children: [
                                                            Text("Payment Status"),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text("(${_body.date.toString().substring(0,10)})"),
                                                        Text("(${_body.time})")
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: (){
                                                        updateStatusDailog(_body.id.toString());
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/status_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Status", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context,
                                                            MaterialPageRoute(builder: (context) => EditAppointment(_body.id.toString())));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/edit_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Edit", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        deleteDailog(_body.id.toString());
                                                      },
                                                      child: Container(
                                                        child: Column(
                                                          children: [
                                                            Image.asset("assets/delete_ic.png"),
                                                            Container(
                                                                margin: EdgeInsets.only(top: 5.0),
                                                                child: Text("Delete", style: TextStyle(fontSize: 12.0),))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xfff5f5f5),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)
                                                          )
                                                      ),
                                                      child: Image.asset("assets/phone_ic.png",
                                                        color: Colors.green,),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                              );
                            }):
                        tab.matchAsPrefix("cancel") != null ?ListView.builder(
                            itemCount: _list.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              Body _body = _list[index];
                              int randomNumber = _random.nextInt(5);
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  child: Card(
                                      color: Colors.white,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)
                                          )
                                      ),
                                      elevation: 10.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)
                                            )
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              gradientColorList[randomNumber],
                                                              gradientColorListLight[randomNumber],
                                                            ],
                                                            begin: const FractionalOffset(0.0, 0.0),
                                                            end: const FractionalOffset(0.0, 1.0),
                                                            stops: [0.0, 1.0],
                                                            tileMode: TileMode.clamp
                                                        )
                                                    ),
                                                    child: Image.asset("assets/user_ic_white.png"),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_body.name.toString()),
                                                        Row(
                                                          children: [
                                                            Text("Payment Status"),
                                                            Container(
                                                              height: 8.0,
                                                              width: 8.0,
                                                              margin: EdgeInsets.only(left: 5.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  gradient: LinearGradient(
                                                                      colors: [
                                                                        Color(0xffFF3D3D),
                                                                        Color(0xffFF663D)
                                                                      ],
                                                                      begin: const FractionalOffset(0.0, 0.0),
                                                                      end: const FractionalOffset(0.0, 1.0),
                                                                      stops: [0.0, 1.0],
                                                                      tileMode: TileMode.clamp
                                                                  )
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text("(${_body.date.toString().substring(0,10)})"),
                                                        Text("(${_body.time})")
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xfff5f5f5),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)
                                                          )
                                                      ),
                                                      child: Image.asset("assets/phone_ic.png",
                                                        color: Colors.green,),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                              );
                            }):
                        tab.matchAsPrefix("completed") != null ?ListView.builder(
                            itemCount: _list.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              int randomNumber = _random.nextInt(5);
                              Body _body = _list[index];
                              return Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  child: Card(
                                      color: Colors.white,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)
                                          )
                                      ),
                                      elevation: 10.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0)
                                            )
                                        ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 35,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        gradient: LinearGradient(
                                                            colors: [
                                                              gradientColorList[randomNumber],
                                                              gradientColorListLight[randomNumber],
                                                            ],
                                                            begin: const FractionalOffset(0.0, 0.0),
                                                            end: const FractionalOffset(0.0, 1.0),
                                                            stops: [0.0, 1.0],
                                                            tileMode: TileMode.clamp
                                                        )
                                                    ),
                                                    child: Image.asset("assets/user_ic_white.png"),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(left: 10.0),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(_body.name.toString()),
                                                        Row(
                                                          children: [
                                                            Text("Payment Status"),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Text("(${_body.date.toString().substring(0,10)})"),
                                                        Text("(${_body.time})")
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 20.0),
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                      decoration: BoxDecoration(
                                                          color: Color(0xfff5f5f5),
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(5.0)
                                                          )
                                                      ),
                                                      child: Image.asset("assets/phone_ic.png",
                                                        color: Colors.green,),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  )
                              );
                            }):
                        Container(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],

        ),
      ),
    );
  }

}