import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/city_list_model.dart';
import 'package:shadiapp/Models/country_list_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/cast/cast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryCity extends StatefulWidget {
  @override
  State<CountryCity> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CountryCity> {

  bool ActiveConnection = false;
  SharedPreferences? _preferences;
  late UserDetailModel _userDetailModel;
  late UpdateUserModel _updateUserModel;
  late CountryListModel _countryListModel;
  late CItyListModel _cItyListModel;
  String T = "";
  String firstName = "";
  String lastName = "";
  String birthDate = "";
  String gender = "";
  String height = "";
  String weight = "";
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
  bool isLoad = false;

  List<String> countryList = [
    "Select country"
  ];
  List<String> cityList = [
    "Select country"
  ];

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
      if (_userDetailModel.data![0].country == ""){
        country = "Select country";
      }else {
        country = _userDetailModel.data![0].country.toString();
      }
      if(_userDetailModel.data![0].city == ""){
        city = "Select city";
      }else {
        city = _userDetailModel.data![0].city.toString();
      }
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
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

  Future<void> ListCountry() async {
    isLoad = true;
    _countryListModel = await Services.CountryList();
    if (_countryListModel.status == true){
      for(var i = 0; i < _countryListModel.data!.length; i++){
        countryList.add(_countryListModel.data![i].name.toString());
      }
    }
    isLoad = false;
    setState(() {
      country = _userDetailModel.data?[0].country ?? "Select country";
      ListCity(country);
    });
  }

  Future<void> ListCity(String name) async {
    isLoad = true;
    _cItyListModel = await Services.CityList(name);
    if(_cItyListModel.status == true){
      for(var i = 0; i < _cItyListModel.data!.length; i++){
        cityList.add(_cItyListModel.data![i].name.toString());
      }
    }
    isLoad = false;
    setState(() {

    });
  }

  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });

    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser("${_preferences?.getString(ShadiApp.userId)}", firstName,
        lastName, birthDate, gender, country, city, height, weight, maritalStatus, email, lookingFor,
        religion, caste, about, education, company, jobTitle);
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Cast()));
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
    ListCountry();
    CheckUserConnection();
    super.initState();
  }

  String country = 'Select country';
  String city = 'Select city';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: isLoad ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3.0,
        ),
      ): Center(
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
                'I live in',
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
                value: country,
                underline: Container(
                  // height: 1,
                  // margin:const EdgeInsets.only(top: 20),
                  // color: Colors.white,
                ),
                isExpanded: true,
                style: TextStyle(color:Colors.white,fontSize: 16),
                onChanged: (newValue) {
                  setState(() {
                    country = newValue!;
                    city = "Select city";
                    cityList.clear();
                    cityList.add("Select city");
                    ListCity(country);
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return countryList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:country == 'Select country' ? Colors.grey:  Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: countryList // add your own dial codes
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
                'City',
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
                value: city,
                underline: Container(
                  // height: 1,
                  // margin:const EdgeInsets.only(top: 20),
                  // color: Colors.white,
                ),
                isExpanded: true,
                style: TextStyle(color: Colors.white,fontSize: 16),
                onChanged: (newValue) {
                  setState(() {
                    city = newValue!;
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return cityList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:city == 'Select city' ? Colors.grey : Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: cityList // add your own dial codes
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
                'This will appear on Shadi-App, however you can choose to hide or show your country and city.',
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
                        if (country == "Select country"){
                          Toaster.show(context, "Pelase select country");

                        }else{
                          if(city == "Select city"){
                            Toaster.show(context, "Pelase select city");
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

