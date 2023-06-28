import 'dart:math';

import 'package:astro_santhil_app/models/view_customer_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/edit_customer.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:flutter/material.dart';

class ViewCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewCustomerState();
}

class _ViewCustomerState extends State<ViewCustomer> {

  late ViewCustomerModel _customerModel;
  List<Datum> _list = [];
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

  Future<void> customerVeiw() async {
    _pageLoading = true;
    _customerModel = await Services.veiwCustomer();
    if(_customerModel.status == true){
      for(var i = 0; i < _customerModel.data!.length; i++){
        _list = _customerModel.data ?? <Datum> [];
      }
    }
    setState(() {

    });
    _pageLoading = false;
  }

  @override
  void initState() {
    customerVeiw();
    super.initState();
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
                        child: Text("Customer".toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 21.61),),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Container(
                  padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0, bottom: 70.0),
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                  child: _pageLoading? Center(
                    child: CircularProgressIndicator(),
                  ):ListView.builder(
                      itemCount: _list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        Datum _body = _list[index];
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
                                                      Text("(${_body.phone})"),
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
                                                  Text("(${_body.dob.toString().substring(0,10)})"),
                                                  Text("(${_body.birthTime})")
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
                                                onTap: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => EditCustomer(_body.userId.toString())));
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
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}