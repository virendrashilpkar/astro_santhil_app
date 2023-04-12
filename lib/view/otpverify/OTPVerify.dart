
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class OTPVerify extends StatefulWidget {
  @override
  State<OTPVerify> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<OTPVerify> {

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



  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Enter code',
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
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          controller: otp1,
                          decoration: InputDecoration(
                            hintText: '0',
                            counterText: "",
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 29),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          onChanged: (value){
                            if(value.isNotEmpty){
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          style: new TextStyle(color: Colors.white,fontSize: 29),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // return null;
                          },
                          onSaved: (value) {
                            // _phoneNumber = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          controller: otp2,
                          decoration: InputDecoration(
                            hintText: '0',
                            counterText: "",
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 29),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 29),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // return null;
                          },
                          onChanged: (value){
                            if(value.isNotEmpty){
                              FocusScope.of(context).nextFocus();
                            }else{
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          onSaved: (value) {
                            // _phoneNumber = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          controller: otp3,
                          decoration: InputDecoration(
                            hintText: '0',
                            counterText: "",
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 29),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 29),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // return null;
                          },
                          onChanged: (value){
                            if(value.isNotEmpty){
                              FocusScope.of(context).nextFocus();
                            }else{
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          onSaved: (value) {
                            // _phoneNumber = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.next,
                          maxLength: 1,
                          controller: otp4,
                          decoration: InputDecoration(
                            hintText: '0',
                            counterText: "",
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 29),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 29),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // return null;
                          },
                          onChanged: (value){
                            if(value.isNotEmpty){
                              FocusScope.of(context).nextFocus();
                            }else{
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          onSaved: (value) {
                            // _phoneNumber = value!;
                          },
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.center,
                          textInputAction: TextInputAction.done,
                          maxLength: 1,
                          controller: otp5,
                          decoration: InputDecoration(
                            hintText: '0',
                            counterText: "",
                            hintStyle: new TextStyle(color: Colors.grey,fontSize: 29),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyan),
                            ),
                          ),
                          style: new TextStyle(color: Colors.white,fontSize: 29),
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return 'Please enter your phone number';
                            // }
                            // return null;
                          },
                          onChanged: (value){
                            if(value.isEmpty){
                              FocusScope.of(context).previousFocus();
                            }else{
                              FocusScope.of(context).unfocus();
                            }
                          },
                          onSaved: (value) {
                            // _phoneNumber = value!;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 95,right: 50,left: 50),
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
                        Navigator.of(context).pushNamed('CountryCity');
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
                // Navigator.of(context).pushNamed('ProblemAuth');
              },
              splashColor: CommonColors.themeblack,
              highlightColor: CommonColors.themeblack,
              child: Container(
                margin: const EdgeInsets.only(top: 20,bottom: 25),
                child: Text(
                  'Send a new code again',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
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

