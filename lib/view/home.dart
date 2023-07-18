import 'package:astro_santhil_app/main.dart';
import 'package:astro_santhil_app/view/add_appointment.dart';
import 'package:astro_santhil_app/view/appointment.dart';
import 'package:astro_santhil_app/view/category_managmet.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:astro_santhil_app/view/payments.dart';
import 'package:astro_santhil_app/view/slot_booking.dart';
import 'package:astro_santhil_app/view/view_customer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();

}

class _HomeState extends State<Home>{
  var image = [
    "assets/user_ic_white.png", "assets/today_ic.png", "assets/upcoming_ic.png", "assets/pending_ic.png",
    "assets/cancel_appointment_ic.png", "assets/add_appointment_ic.png", "assets/pay_repo_ic.png",
    "assets/category_manage_ic.png", "assets/view_customer.png"
  ];

  var bgImgae = [
    "assets/Vector (1).png", "assets/Vector (2).png", "assets/Vector (3).png", "assets/Vector (4).png",
    "assets/Vector (5).png", "assets/Vector (6).png", "assets/Vector (7).png", "assets/Vector (8).png",
    "assets/Vector (9).png",
  ];

  var name = [
    "Add\nCustomer", "Today`s Appointment", "Upcoming Appointment", "Pending Appointment", "Cancelled Appointment",
    "Add Appointment", "Payment Reports", "Category Management", "Customer Managment"
  ];
  var navigate = [
    AddAppointment("", ""),
    Appointment("today"),
    Appointment("today"),
    Appointment("pending"),
    Appointment("cancel"),
    SlotBooking(),
    Payments(),
    CategoryManagement(),
    ViewCustomer(),
  ];

  void navigateUser(BuildContext context) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xff1BBF57),
                Color(0xff34E389),
              ],
            )
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
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
                      InkWell(
                        onTap: (){
                          navigateUser(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, top: 3.49, right: 20.0, bottom: 3.49),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(20.0)),
                            color: Color(0xff303030)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Image.asset("assets/log_out_ic.png"),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                                child: Text("Log Out", style: TextStyle(fontSize: 12.09, color: Colors.white),),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.22, top: 50.0),
                  child: Row(
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.white,
                          child: Container(
                              child: Image.asset("assets/green text-01.png",
                              width: 90,)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text("admin".toUpperCase(), style: TextStyle(fontSize: 16.19),
                              textAlign: TextAlign.start,),
                            ),
                            Container(
                              child: Text("Astro Senthil",  textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 32.39, color: Colors.white),),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30.36),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, top: 35.0, right: 10.0),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            mainAxisSpacing: 30.0,
                            crossAxisSpacing: 20.0
                          ),
                          itemCount: name.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => navigate[index]));
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage: AssetImage("${bgImgae[index]}"),
                                    backgroundColor: Colors.transparent,
                                    child: Image.asset("${image[index]}",
                                    height: 20.0,),
                                  ),
                                  Expanded(
                                    child: Text("${name[index]}", textAlign: TextAlign.center,
                                    style: TextStyle(),),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
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