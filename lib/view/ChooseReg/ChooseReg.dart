import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/view/accountrecover/AccountRecover.dart';
import 'package:shadiapp/view/problemauth/ProblemAuth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseReg extends StatefulWidget {
  @override
  State<ChooseReg> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChooseReg> {

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
    // Future.delayed(Duration(seconds: 4), () {
    //   navigateUser(context);
    // });
  }

  final Uri toLaunch = Uri(scheme: 'https', host: 'www.cylog.org', path: 'headers/');
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Center(

        child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo_name.png',
                height: 62,
                width: 215,
                fit: BoxFit.cover,
              ),
            ),
            new SizedBox(height: 110,),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    'Before you login please read our privacy policy\nand find out how we handle your data.\nBy logging in you agree to our terms.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: (){
                    // _launchInBrowser(toLaunch);
                    Navigator.of(context).pushNamed('AccountRecover');
                  },
                  splashColor: CommonColors.themeblack,
                  highlightColor: CommonColors.themeblack,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      'Privacy Policy and Cookie Policy.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                new Container(margin: const EdgeInsets.only(left: 70,right: 70,top: 5,bottom: 25),height: 1,color: Colors.white,)
              ],
            ),


            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(25)),
              ),
              child:
              Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 27.0,
                          height: 27.0,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          // decoration: BoxDecoration(
                          //   color: Colors.deepPurple,
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8.0),
                          //   ),
                          // ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/google_ref.png"))),
                      Expanded(
                          child: Center(
                            child: Text("Sign in through Google", style: TextStyle(
                                color: CommonColors.themeblack, fontSize: 12,fontWeight: FontWeight.w600),),
                          )),
                      Container(
                        width: 27.0,
                        height: 27.0,
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerLeft,
                      ),

                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {},splashColor: Colors.blue.withOpacity(0.2),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 27.0,
                          height: 27.0,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          // decoration: BoxDecoration(
                          //   color: Colors.deepPurple,
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8.0),
                          //   ),
                          // ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/facebook_ref.png"))),
                      Expanded(
                          child: Center(
                            child: Text("Sign in through Facebook", style: TextStyle(
                                color: CommonColors.themeblack, fontSize: 12,fontWeight: FontWeight.w600),),
                          )),
                      Container(
                        width: 27.0,
                        height: 27.0,
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerLeft,
                      ),

                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {},splashColor: Colors.blue.withOpacity(0.2),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                const BorderRadius.all(Radius.circular(25)),
              ),
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width: 27.0,
                          height: 27.0,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.centerLeft,
                          // decoration: BoxDecoration(
                          //   color: Colors.deepPurple,
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(8.0),
                          //   ),
                          // ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Image.asset("assets/phone_ref.png"))),
                      Expanded(
                          child: Center(
                            child: Text("Log in by phone number", style: TextStyle(
                                color: CommonColors.themeblack, fontSize: 12,fontWeight: FontWeight.w600),),
                          )),
                      Container(
                        width: 27.0,
                        height: 27.0,
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerLeft,
                      ),

                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {
                        Navigator.of(context).pushNamed('PhoneLogin');
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
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed('ProblemAuth');
          },
          splashColor: CommonColors.themeblack,
          highlightColor: CommonColors.themeblack,
           child: Container(
              margin: const EdgeInsets.only(top: 20,bottom: 25),
              child: Text(
                'Authorization problems?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        )
          ],
        ),
      ),
    );
  }
}

