import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/city_list_model.dart';
import 'package:shadiapp/Models/country_list_model.dart';
import 'package:shadiapp/Models/statelistmodel.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/cast/cast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../commonpackage/SearchChoices.dart';

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
  late StateListModel _stateListModel;
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

  String zodiac_sign = "";
  String education_level = "";
  String covid_vaccine = "";
  String pets = "";
  String dietary_preference = "";
  String sleeping_habits = "";
  String social_media = "";
  String workout = "";
  String smoking = "";
  String health = "";
  String drinking = "";
  String personality_type = "";

  bool clickLoad = false;
  bool isLoad = false;
  List<String> countryList = [
    "Select country"
  ];
  List<String> cityList = [
    "Select city"
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
      // if (_userDetailModel.data![0].country == ""){
      //   country = "Select country";
      // }else {
        country = _userDetailModel.data![0].country.toString();

        if(country!=""){
          Liststate(country);
        }

      // }
      // print(">>>>>>>>>>${_userDetailModel.data![0].country}");
      // if(_userDetailModel.data![0].city == ""){
      //   city = "Select city";
      // }else {
        city = _userDetailModel.data![0].city.toString();
        // cityList.add(city);
      // }
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

      zodiac_sign = _userDetailModel.data![0].zodiacSign.toString();
      covid_vaccine = _userDetailModel.data![0].covidVaccine.toString();
      pets = _userDetailModel.data![0].pets.toString();
      dietary_preference = _userDetailModel.data![0].dietaryPreference.toString();
      education_level = _userDetailModel.data![0].educationLevel.toString();
      sleeping_habits = _userDetailModel.data![0].sleepingHabits.toString();
      social_media = _userDetailModel.data![0].socialMedia.toString();
      workout = _userDetailModel.data![0].workout.toString();
      health = _userDetailModel.data![0].health.toString();
      smoking = _userDetailModel.data![0].smoking.toString();
      drinking = _userDetailModel.data![0].drinking.toString();
      personality_type = _userDetailModel.data![0].personalityType.toString();
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
        countryitems.add(DropdownMenuItem(
          value: _countryListModel.data![i].name.toString(),
          child: Text(_countryListModel.data![i].name.toString()),
        ));
      }
      // if(country!=""){
      //   ListCity(country);
      // }
      // country = _userDetailModel.data?[0].country ?? "Select country";
    }
    isLoad = false;
    setState(() {
    });
  }
  Future<void> Liststate(name) async {
    isLoad = true;
    stateitems.clear();
    countryList.clear();
    _stateListModel = await Services.StateList(name,"");
    if (_stateListModel.status == true){

      for(var i = 0; i < _stateListModel.data!.length; i++){
        countryList.add(_stateListModel.data![i].name.toString());
        stateitems.add(DropdownMenuItem(
          value: _stateListModel.data![i].name.toString(),
          child: Text(_stateListModel.data![i].name.toString()),
        ));
      }
    }
    isLoad = false;
    setState(() {
    });
  }

  Future<void> ListCity(String name) async {
    setState(() {
      isLoad = true;
    });
    cityList.clear();

    cityitems.clear();
    List<CountryData> countryDataList = _countryListModel.data!.where((user) {
      return user.name == country;
    }).toList();
    List<Statedata> stateDataList = _stateListModel.data!.where((user) {
      return user.name == state;
    }).toList();

    _cItyListModel = await Services.CityList("",stateDataList.isNotEmpty ? "${stateDataList[0]?.isoCode}":"",countryDataList.isNotEmpty ? "${countryDataList[0]?.countryCode}":"");
    if(_cItyListModel.status == true){
      cityList.add("Select city");
      for(var i = 0; i < _cItyListModel.data!.length; i++){
        cityList.add(_cItyListModel.data![i].name.toString());
        cityitems.add(DropdownMenuItem(
          value: _cItyListModel.data![i].name.toString(),
          child: Text(_cItyListModel.data![i].name.toString()),
        ));
      }
    }
    setState(() {
      isLoad = false;
    });

  }

  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });

    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser2(
        {
          "userId": "${_preferences?.getString(ShadiApp.userId)}",
          "country": country,
          "city": city,
          "state": state,
        }
    );
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


  String selectedValueSingleDialog="Select country";
  List<DropdownMenuItem> countryitems = [];
  List<DropdownMenuItem> stateitems = [];
  List<DropdownMenuItem> cityitems = [];

  @override
  void initState() {
    userDetail();
    ListCountry();
    CheckUserConnection();
    super.initState();
  }

  String country = 'Select country';
  String state = 'Select state';
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
      ): SingleChildScrollView(
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
              // height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(40)),
              ),
              child:

              SearchChoices.single(
                items: countryitems,
                value: country,
                hint: "Select country",
                disabledHint: "Disabled",
                searchHint: "Select country",
                style: TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    country = value;
                    city = "Select city";
                    cityList.clear();
                    cityList.add("Select city");
                    state = 'Select state';
                    city = 'Select city';
                    Liststate(country);
                  });
                },
                displayClearIcon: false,
                isExpanded: true,
              ),
            ),
            new SizedBox(height: 15,),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'State',
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
              child:
              SearchChoices.single(
                items: stateitems,
                value: state,
                hint: "Select State",
                searchHint: "Select State",
                style: TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    state = value;
                    city="Select city";
                    ListCity(state);
                  });
                },
                displayClearIcon: false,
                isExpanded: true,
              ),
              // DropdownButton<String>(
              //   value: city,
              //   underline: Container(
              //     // height: 1,
              //     // margin:const EdgeInsets.only(top: 20),
              //     // color: Colors.white,
              //   ),
              //   isExpanded: true,
              //   style: TextStyle(color: Colors.white,fontSize: 16),
              //   onChanged: (newValue) {
              //     setState(() {
              //       city = newValue!;
              //     });
              //   },
              //   selectedItemBuilder: (BuildContext context) {
              //     return cityList.map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(value,style: TextStyle(color:city == 'Select city' ? Colors.grey : Colors.white,fontSize: 16),),
              //       );
              //     }).toList();
              //   },
              //   iconSize: 24,
              //   icon: Icon(Icons.arrow_forward_ios),
              //   iconDisabledColor: Colors.white,
              //   items: cityList // add your own dial codes
              //       .map<DropdownMenuItem<String>>((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
              //     );
              //   }).toList(),
              // ),
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
              child:
              SearchChoices.single(
                items: cityitems,
                value: city,
                hint: "Select city",
                searchHint: "Select city",
                style: TextStyle(color: Colors.white),
                underline: Container(),
                onChanged: (value) {
                  setState(() {
                    city = value;
                  });
                },
                displayClearIcon: false,
                isExpanded: true,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 16,bottom: 30,left: 28,right: 28),
              child: Text(
                'This will appear on Shaadi-App, however you can choose to hide or show your country and city.',
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
                        }else if(state == "Select state"){
                          Toaster.show(context, "Pelase select state");
                        }else if(city == "Select city"){
                          Toaster.show(context, "Pelase select city");
                        }
                        else{
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
    );
  }
}

