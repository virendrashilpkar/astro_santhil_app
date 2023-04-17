import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountRecover extends StatefulWidget {
  @override
  State<AccountRecover> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AccountRecover> {

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } catch (Error) {
      // setState(() {
      ActiveConnection = false;
      T = "Turn On the data and repress again";
      // });
    }
  }

  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                '...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/back_icon.png',
                  ),
                ),
              ),
            ),
            new SizedBox(height: 35,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Account recovery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new SizedBox(height: 27,),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration:  InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email address',
                                hintStyle: TextStyle(color: CommonColors.editblack, fontSize: 16,fontWeight: FontWeight.w400,)
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 20,bottom: 113,left: 20,right: 20),
              child: Text(
                'Check your email to recover your account.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: CommonColors.buttonorg,
                borderRadius:
                const BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[

                      Expanded(
                          child: Center(
                            child: Text("Send Email", style: TextStyle(
                                color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
                          )),
                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {

                      },splashColor: Colors.blue.withOpacity(0.2),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

