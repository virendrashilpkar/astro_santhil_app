import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/user_detail_model.dart';

class HeightWeight extends StatefulWidget {
  @override
  State<HeightWeight> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HeightWeight> {

  bool ActiveConnection = false;
  String T = "";
  SharedPreferences? _preferences;
  late UserDetailModel _userDetailModel;
  late UpdateUserModel _updateUserModel;
  String firstName = "";
  String lastName = "";
  String birthDate = "";
  String gender = "";
  String country = "";
  String city = "";
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String maritalStatus = "";
  String email = "";
  String lookingFor = "";
  String religion = "";
  String caste = "";
  String about = "";
  String education = "";
  String company = "";
  String jobTitle = "";

  bool clickLoad = false;

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

  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      birthDate = _userDetailModel.data![0].birthDate.toString();
      gender = _userDetailModel.data![0].gender.toString();
      country = _userDetailModel.data![0].country.toString();
      city = _userDetailModel.data![0].city.toString();
      weight.text = _userDetailModel.data![0].weight.toString();
      height.text = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
      religion = _userDetailModel.data![0].religion.toString();
      about = _userDetailModel.data![0].about.toString();
      education = _userDetailModel.data![0].education.toString();
      company = _userDetailModel.data![0].company.toString();
      jobTitle = _userDetailModel.data![0].jobTitle.toString();
      setState(() {

      });
    }
  }

  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });

    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser("${_preferences?.getString(ShadiApp.userId)}", firstName,
        lastName, birthDate, gender, country, city, height.text, weight.text, maritalStatus, email,
        lookingFor, religion, caste, about, education, company, jobTitle);
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).pushNamed('LookingFor');
    }else{
      Toaster.show(context, _updateUserModel.message.toString());
    }
    setState(() {
      clickLoad = false;
    });
  }

  @override
  void initState() {
    userDetail();
    CheckUserConnection();
    super.initState();
  }

  TextEditingController intialdateval = TextEditingController();


  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2030));
    if (picked != null)
      setState(() => {
            intialdateval.text = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}"

          }
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: SingleChildScrollView(
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: MediaQuery.of(context).padding.top+20,),
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
              new SizedBox(height: 40,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My height is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 15,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: height,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Height',
                          border: InputBorder.none,
                          hintStyle: new TextStyle(color: Colors.grey,fontSize: 16),
                        ),
                        style: new TextStyle(color: Colors.white,fontSize: 16),
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
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                  ],
                ),
              ),
              new SizedBox(height: 26,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My weight is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 15,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: weight,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Weight',
                          border: InputBorder.none,
                          hintStyle: new TextStyle(color: Colors.grey,fontSize: 16),
                        ),
                        style: new TextStyle(color: Colors.white,fontSize: 16),
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
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                  ],
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 15,bottom: 15,left: 28,right: 28),
                child: Text(
                  'This will appear on Shadi-App, and you will not be able to change it. However you can choose to hide or show your height and weight.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
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
                        clickLoad ? Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3.0,
                              ),
                            )
                        ):
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
                          if(height.text.isEmpty){
                            Toaster.show(context, "Pelase Enter your height");
                          }else if(weight.text.isEmpty){
                            Toaster.show(context, "Pelase Enter your weight");
                          }else {
                            updateUser();
                          }
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
      ),
    );
  }
}

