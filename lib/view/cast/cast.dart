import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Cast extends StatefulWidget {
  @override
  State<Cast> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Cast> {

  bool ActiveConnection = false;
  SharedPreferences? _preferences;
  late UserDetailModel _userDetailModel;
  late UpdateUserModel _updateUserModel;
  String T = "";
  String firstName = "";
  String lastName = "";
  String birthDate = "";
  String gender = "";
  String country = "";
  String city = "";
  String height = "";
  String weight = "";
  String maritalStatus = "";
  String email = "";
  String lookingFor = "";
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

  getAsync() async {
    try{
      _preferences = await SharedPreferences.getInstance();
      setState(() {

      });
    }catch (e) {
      print(e);
    }
  }

  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      if(_userDetailModel.data![0].birthDate == null){
        birthDate = "";
      }else {
        birthDate = _userDetailModel.data![0].birthDate.toString();
      }
      gender = _userDetailModel.data![0].gender.toString();
      country = _userDetailModel.data![0].country.toString();
      city = _userDetailModel.data![0].city.toString();
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
      if (_userDetailModel.data![0].religion == null) {
        religion = "Select religion";
      }else {
        religion = _userDetailModel.data![0].religion.toString();
      }
      if (_userDetailModel.data![0].caste == null){
        cast = "Select cast";
      }else {
        cast = _userDetailModel.data![0].caste.toString();
      }
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
        lastName, birthDate, gender, country, city, height, weight, maritalStatus, email, lookingFor, religion,
        cast, about, education, company, jobTitle);
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).pushNamed('NameDOB');
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

  String religion = 'Select religion';
  String cast = 'Select cast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Center(
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
                'Religion',
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
              child: DropdownButton<String>(
                value: religion,
                underline: Container(
                  // height: 1,
                  // margin:const EdgeInsets.only(top: 20),
                  // color: Colors.white,
                ),
                isExpanded: true,
                style: TextStyle(color:Colors.white,fontSize: 16),
                onChanged: (newValue) {
                  setState(() {
                    religion = newValue!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return ['Select religion', 'Hindu', 'Muslim', 'Sikh'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:religion == 'Select religion' ? Colors.grey:  Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: <String>['Select religion', 'Hindu', 'Muslim', 'Sikh'] // add your own dial codes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                  );
                }).toList(),
              ),
            ),
            new SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Cast',
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
              child: DropdownButton<String>(
                value: cast,
                underline: Container(
                  // height: 1,
                  // margin:const EdgeInsets.only(top: 20),
                  // color: Colors.white,
                ),
                isExpanded: true,
                style: TextStyle(color: Colors.white,fontSize: 16),
                onChanged: (newValue) {
                  setState(() {
                    cast = newValue!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return ['Select cast', 'punjabi', 'gujrati', 'bangali', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:cast == 'Select cast' ? Colors.grey : Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: <String>['Select cast', 'punjabi', 'gujrati', 'bangali', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'] // add your own dial codes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                  );
                }).toList(),
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 16,bottom: 30,left: 28,right: 28),
              child: Text(
                'This will appear on Shadi-App, however you can choose to hide or show your religion and cast.',
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
                        if (religion == "Select religion"){
                          Toaster.show(context, "Pelase select religion");

                        }else{
                          if(cast == "Select cast"){
                            Toaster.show(context, "Pelase select cast");
                          }else {
                            updateUser();
                          }
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
    );
  }
}

