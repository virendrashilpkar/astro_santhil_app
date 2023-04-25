
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class PhoneLogin extends StatefulWidget {
  @override
  State<PhoneLogin> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PhoneLogin> {

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
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'What’s your\nphone number',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.start,
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
                        flex: 1,
                        child: Column(
                          children: [
                            SizedBox(height: 2,),
                            DropdownButton<String>(
                              value: _dialCode,
                              underline: Container(
                                // height: 1,
                                // margin:const EdgeInsets.only(top: 20),
                                // color: Colors.white,
                              ),
                              style: TextStyle(color: Colors.white,fontSize: 20),
                              onChanged: (newValue) {
                                setState(() {
                                  _dialCode = newValue!;
                                });
                              },
                              selectedItemBuilder: (BuildContext context) {
                                return ['+1', '+91', '+44', '+81'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400,),),
                                  );
                                }).toList();
                              },
                              iconSize: 30,
                              iconDisabledColor: Colors.white,
                              items: <String>['+1', '+91', '+44', '+81'] // add your own dial codes
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 20,fontWeight: FontWeight.w400,),),
                                );
                              }).toList(),
                            ),
                            Container(
                              height: 1,
                              width: double.maxFinite,
                              margin:const EdgeInsets.only(top: 1),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '1234567890',
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 20,fontWeight: FontWeight.w400,),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w400,),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phoneNumber = value!;
                          },
                        ),
                      ),
                      // Expanded(
                      //     child: Center(
                      //       child: TextFormField(
                      //         decoration:  InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: 'Email address',
                      //             hintStyle: TextStyle(color: CommonColors.editblack, fontSize: 16)
                      //         ),
                      //       ),
                      //     )),
                    ],
                  ),
                ],
              ),
            ),


            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 95,right: 70,left: 70),
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
                                color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
                          )),
                    ],
                  ),
                  SizedBox.expand(
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(onTap: () {
                        Navigator.of(context).pushNamed('OTPVerify');

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
            // InkWell(
            //   onTap: (){
            //     Navigator.of(context).pushNamed('ForgotPassword');
            //   },
            //   splashColor: CommonColors.themeblack,
            //   highlightColor: CommonColors.themeblack,
            //   child: Container(
            //     margin: const EdgeInsets.only(top: 20,bottom: 25),
            //     child: Text(
            //       'Forgot Password',
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 15,
            //         fontWeight: FontWeight.w400,
            //       ),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

