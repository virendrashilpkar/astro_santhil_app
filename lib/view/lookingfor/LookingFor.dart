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

class LookingFor extends StatefulWidget {
  @override
  State<LookingFor> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LookingFor> {

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
  String youarevalue="";
  String lookingvalue="";
  String Maritalstatus="Marital status";
  List<String> maritalStatuses = [
    'Marital status',
    'Single',
    'unmarried'
    'Married',
    'Divorced',
    'Widowed',
  ];
  List<String> youarea=["Man","Woman"];
  List<String> lookingfor=["Woman","Man","Both"];

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
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      if(_userDetailModel.data![0].maritalStatus == "null"){
        Maritalstatus = "Marital status";
      }else {
        Maritalstatus = _userDetailModel.data![0].maritalStatus.toString();
      }
      email = _userDetailModel.data![0].email.toString();
      lookingFor = _userDetailModel.data![0].lookingFor.toString();
      if(gender == "male"){
        youarevalue = "Man";
      }else if(gender == "female"){
        youarevalue = "Woman";
      }
      if (lookingFor == "female"){
        lookingvalue == "Woman";
      } else if (lookingFor == "male"){
        lookingvalue == "Man";
      }
      religion = _userDetailModel.data![0].religion.toString();
      caste = _userDetailModel.data![0].caste.toString();
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
    print("sdfhghdsfhgdf ${lookingFor}");
    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser("${_preferences?.getString(ShadiApp.userId)}", firstName,
        lastName, birthDate, gender, country, city, height, weight, Maritalstatus, email, lookingFor,
        religion, caste, about, education, company, jobTitle);
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).pushNamed('AddPhotos');
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
              new SizedBox(height: 30,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'You are a',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                itemCount: youarea.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: youarevalue == youarea[index] ? CommonColors.buttonorg:CommonColors.themeblack ,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: youarevalue == youarea[index] ?  null:Border.all(color: Colors.white),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[

                            Expanded(
                                child: Center(
                                  child: Text("${youarea[index]}", style: TextStyle(
                                      color: youarevalue == youarea[index] ? Colors.white:Colors.white.withOpacity(0.6), fontSize:  16,fontWeight: youarevalue == youarea[index] ? FontWeight.w600 : FontWeight.w400),),
                                )),
                          ],
                        ),
                        SizedBox.expand(
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(onTap: () {
                              setState(() {
                                if(youarevalue.isEmpty){
                                  youarevalue=youarea[index];
                                }else{
                                  if(youarevalue==youarea[index]){
                                    youarevalue="";
                                  }else {
                                    youarevalue = youarea[index];
                                    if(youarevalue == "Man"){
                                      gender = "male";
                                    }else if(youarevalue == "Woman"){
                                      gender = "female";
                                    }
                                  }
                                }
                              });

                            },splashColor: Colors.blue.withOpacity(0.2),
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              new SizedBox(height: 26,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Looking for',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              new SizedBox(height: 15,),
              ListView.builder(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lookingfor.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                      color: lookingvalue == lookingfor[index] ? CommonColors.buttonorg:CommonColors.themeblack ,
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: lookingvalue == lookingfor[index] ?  null:Border.all(color: Colors.white),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[

                            Expanded(
                                child: Center(
                                  child: Text("${lookingfor[index]}",style: TextStyle(
                                      color: lookingvalue == lookingfor[index] ? Colors.white:Colors.white.withOpacity(0.6), fontSize:  16,fontWeight: lookingvalue == lookingfor[index] ? FontWeight.w600 : FontWeight.w400),),
                                )),
                          ],
                        ),
                        SizedBox.expand(
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(onTap: () {
                              setState(() {
                                if(lookingvalue.isEmpty){
                                  lookingvalue=lookingfor[index];
                                }else{
                                  if(lookingvalue==lookingfor[index]){
                                    lookingvalue="";
                                  }else {
                                    lookingvalue = lookingfor[index];
                                  }
                                }
                                if(lookingvalue == "Woman"){
                                  lookingFor = "female";
                                }if(lookingvalue == "Man"){
                                  lookingFor = "male";
                                }if(lookingvalue == "Both"){
                                  lookingFor = "both";
                                }
                                print("objectaklsdlkj ${lookingvalue}");
                                print("objectaklsdlkj ${lookingFor}");
                              });

                            },splashColor: Colors.blue.withOpacity(0.2),
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),


              new SizedBox(height: 26,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'My marital status is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              new SizedBox(height: 10,),
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
                  value: Maritalstatus,
                  underline: Container(
                    // height: 1,
                    // margin:const EdgeInsets.only(top: 20),
                    // color: Colors.white,
                  ),
                  isExpanded: true,
                  style: TextStyle(color: Colors.white,fontSize: 16),
                  onChanged: (newValue) {
                    setState(() {
                      Maritalstatus = newValue!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return maritalStatuses.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color:Maritalstatus=="Marital status" ? Colors.grey : Colors.white,fontSize: 16),),
                      );
                    }).toList();
                  },
                  iconSize: 24,
                  icon: Icon(Icons.arrow_forward_ios),
                  iconDisabledColor: Colors.white,
                  items:maritalStatuses// add your own dial codes
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                    );
                  }).toList(),
                ),
              ),


              new SizedBox(height: 40,),

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
                          if(youarevalue == ""){
                            Toaster.show(context, "Pelase Select your gender");
                          }else if (lookingvalue == ""){
                            Toaster.show(context, "Pelase select looking for");
                          }else if(Maritalstatus == "Marital status"){
                            Toaster.show(context, "Pelase Select marital status");
                          }
                          else {
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
              new SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

