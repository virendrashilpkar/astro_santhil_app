
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ForgotPassword> {

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




  final _formKey = GlobalKey<FormState>();
  String _dialCode = '+1'; // default dial code
  String _phoneNumber="";
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
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Forgot password ?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            new SizedBox(height: 50,),
            Container(
              // height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              // decoration: BoxDecoration(
                // color: Colors.white,
                // borderRadius:
                // const BorderRadius.all(Radius.circular(25)),
              // ),
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Center(
                            child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your email',
                                    hintStyle: new TextStyle(color: Colors.grey,fontSize: 20),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.cyan),
                                    ),
                                  ),
                                  style: new TextStyle(color: Colors.white,fontSize: 20),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your phone number';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    // _phoneNumber = value!;
                                  },
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),


            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 28,right: 50,left: 50),
              // margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            child: Text("Continue", style: TextStyle(
                                color: Colors.white, fontSize: 20),),
                          )),
                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {
                        // Navigator.of(context).pushNamed('OTPVerify');

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

            Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10),
              child: Text(
                'Or',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                // color: Colors.white,
                  border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
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
                                color: Colors.white, fontSize: 12),),
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
          ],
        ),
      ),
    );
  }
}

