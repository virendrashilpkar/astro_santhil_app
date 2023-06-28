import 'dart:math';

import 'package:astro_santhil_app/models/payment_view_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:flutter/material.dart';

class Payments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentsState();

}

class _PaymentsState extends State<Payments>{

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
  late PaymentViewModel _paymentViewModel = PaymentViewModel();
  List<Body> _list = [];
  DateTime? fromDate;
  String? selectedFromDate;
  DateTime? toDate;
  String? selectedToDate;

  void fromdateMethod() async {
    fromDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    int? month = fromDate?.month;
    String? fm=""+ "${month}";
    String? fd=""+"${fromDate?.day}";
    if(month!<10){
      fm ="0"+"${month}";
      print("fm ${fm}");
    }
    if (fromDate!.day<10){
      fd="0"+"${fromDate?.day}";
      print("fd ${fd}");
    }
    if(fromDate != null){
      print('Date Selecte : ${fromDate?.day ??""}-${fromDate?.month ??""}-${fromDate?.year ??""}');
      setState(() {
        selectedFromDate ='${fromDate?.year??""}-${fm}-${fd}';
        print("selectedFromDate ${selectedFromDate?.split(" ")[0]}");
      });
    }
  }

  void toDateMethod() async {
    toDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    int? month = toDate?.month;
    String? fm=""+ "${month}";
    String? fd=""+"${toDate?.day}";
    if(month!<10){
      fm ="0"+"${month}";
      print("fm ${fm}");
    }
    if (toDate!.day<10){
      fd="0"+"${toDate?.day}";
      print("fd ${fd}");
    }
    if(toDate != null){
      print('Date Selecte : ${toDate?.day ??""}-${toDate?.month ??""}-${toDate?.year ??""}');
      setState(() {
        selectedToDate ='${toDate?.year??""}-${fm}-${fd}';
        print("selectedFromDate ${selectedToDate?.split(" ")[0]}");
      });
    }
  }

  Future<void> payment() async {
    _paymentViewModel = await Services.paymentList(selectedFromDate.toString(), selectedToDate.toString());
    if(_paymentViewModel.status == true){
      for(var i = 0; i < _paymentViewModel.body!.length; i++){
        _list = _paymentViewModel.body ?? <Body> [];
      }
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
            // physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Container(
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
                          child: Text("PAYMENTS", style: TextStyle(color: Colors.white, fontSize: 21.61),),
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
                ),
                SizedBox(
                  height: 66.69,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("From Date", style: TextStyle(color: Colors.white),),
                        InkWell(
                          onTap: (){
                            fromdateMethod();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0)
                              )
                            ),
                            child: Row(
                              children: [
                                Text(selectedFromDate != null ? "${selectedFromDate}":
                                  "(DD/MM/YYYY)", style: TextStyle(color: Colors.white),),
                                Container(
                                  margin: EdgeInsets.only(left: 11.0),
                                  child: Image.asset("assets/ic_down.png"),
                                )

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("To Date", style: TextStyle(color: Colors.white),),
                        InkWell(
                          onTap: (){
                            toDateMethod();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 5.0),
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0)
                              )
                            ),
                            child: Row(
                              children: [
                                Text(selectedToDate != null ? "${selectedToDate}":
                                "(DD/MM/YYYY)", style: TextStyle(color: Colors.white),),
                                Container(
                                  margin: EdgeInsets.only(left: 11.0),
                                  child: Image.asset("assets/ic_down.png"),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        payment();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 15.0),
                        alignment: Alignment.center,
                        child: Icon(Icons.search,
                        color: Colors.white,
                        size: 30.0,),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 69.12,
                ),
                Text("TOTAL AMOUNT", style: TextStyle(color: Colors.white, fontSize: 21.55),),
                Container(
                  margin: EdgeInsets.only(top: 13.94),
                  padding: EdgeInsets.only(left: 43.62, top: 26.9, right: 43.62, bottom: 12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0)
                    ),
                    color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Text("Rs.${_paymentViewModel.totalFees ?? "4,180.20"}", style: TextStyle(fontSize: 32.33, fontWeight: FontWeight.w600)),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Color(0xff1BBF57),
                                Color(0xff34E389)
                              ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0)
                          )
                        ),
                        padding: EdgeInsets.only(left: 39.13, top: 6.35, right: 37.26, bottom: 7.19),
                        child: Text("View", style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.89,
                ),
                Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height/2,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 26.93),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("LATEST PAYMENT HISTORY", style: TextStyle(color: Color(0xff019AD6), fontSize: 16.16),),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 10.0, top: 21.53, right: 10.0),
                            child: ListView.builder(
                                itemCount: _list.length,
                                shrinkWrap: true,
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
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
                                                            Text("${_body.name ?? "Name"}"),
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
                                                            Text("(${_body.date.toString().substring(0,10) ?? "(DD/MM/YYYY)"})"),
                                                            Text("(${_body.time ?? "(00:00AM)"})")
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 20.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              Image.asset("assets/status_ic.png"),
                                                              Container(
                                                                  margin: EdgeInsets.only(top: 5.0),
                                                                  child: Text("Status", style: TextStyle(fontSize: 12.0),))
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
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
                                                        Container(
                                                          child: Column(
                                                            children: [
                                                              Image.asset("assets/delete_ic.png"),
                                                              Container(
                                                                  margin: EdgeInsets.only(top: 5.0),
                                                                  child: Text("Delete", style: TextStyle(fontSize: 12.0),))
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Container(
                                                          child: Text("Rs.${_body.fees ?? "2,030.80"}"),
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
                                }),
                          ),
                        )
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}