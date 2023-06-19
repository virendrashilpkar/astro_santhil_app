import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/age_height_range_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/ChooseReg/ChooseReg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';


class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Settings> {

  bool ActiveConnection = false;
  String T = "";
  late UserDetailModel _userDetailModel;
  late SharedPreferences _preferences;
  late AgeHeightRangeModel _rangeModel;
  String email = "";
  String phone = "";
  String minAge = "";
  String maxAge = "";
  String minHeight = "";
  String maxHeight = "";

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

  List<File?> imagelist = List.filled(6, null);

  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      email = _userDetailModel.data![0].email.toString();
      phone = _userDetailModel.data![0].phone.toString();
      minAge = _userDetailModel.data![0].minAge.toString();
      maxAge = _userDetailModel.data![0].maxAge.toString();
      minHeight = _userDetailModel.data![0].minHeight.toString();
      maxHeight = _userDetailModel.data![0].maxHeight.toString();

      setState(() {

      });
    }
  }

  Future<void> rangeSet() async {
    _preferences = await SharedPreferences.getInstance();
    _rangeModel = await Services.RangeSet(_preferences.getString(ShadiApp.userId).toString(),
        _currentRangeValues.start.toInt(), _currentRangeValues.end.toInt(), _currentheightValues.start.toInt(),
        _currentheightValues.end.toInt());
  }

  @override
  void initState() {
    userDetail();
    CheckUserConnection();
    super.initState();
  }
  List<String> tags = [
    'travel',
    'foodie',
    'fitness',
    'photography',
    'nature',
    'fashion',
    'beauty',
    'health',
    'motivation',
    'entrepreneur',
    'pets',
    'music',
    'art',
    'books',
    'technology',
    'education',
    'cooking',
    'gaming',
    'humor',
    'sports',
    'finance',
    'selfcare',
    'parenting',
    'politics',
    'spirituality'
  ];

  List<int> selectedIndex = [];
  bool GoGlobal = false;
  bool ischeck = false;
  // double value1 = minAge as double;
  TextEditingController tagsearch = TextEditingController();
  RangeValues _currentRangeValues =  RangeValues(18, 29);
  RangeValues _currentheightValues =  RangeValues(0, 10);

  void navigateUser(BuildContext context) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => ChooseReg()),
            (route) => false);

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
              Row(
                children: [
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
                  new Spacer(),
                  new Text("Settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  new Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                  ),
                ],
              ),
              new SizedBox(height: 40,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color:CommonColors.settingblue,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.only(top: 10,bottom: 15),
                child: Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          child: new Text("Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                        ),
                        new SizedBox(width: 13,),
                        Container(
                            decoration: BoxDecoration(
                              color: CommonColors.themeblack,
                              borderRadius: BorderRadius.circular(65),
                            ),
                            // padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
                            alignment: Alignment.center,
                            width:69,
                            height:26,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Free",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.white),),
                              ],
                            )
                        ),
                      ],
                    ),
                    new SizedBox(height: 12,),
                    new Container(
                      child: new Text("Priority Likes, see who likes you and more",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color:CommonColors.bluepro,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.only(top: 10,bottom: 15),
                child: Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          child: new Text("Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                        ),
                        new SizedBox(width: 13,),
                        Container(
                            decoration: BoxDecoration(
                              color: CommonColors.white,
                              borderRadius: BorderRadius.circular(65),
                            ),
                            // padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
                            alignment: Alignment.center,
                            width:69,
                            height:26,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Premium",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: CommonColors.bluepro),),
                              ],
                            )
                        ),
                      ],
                    ),
                    new SizedBox(height: 12,),
                    new Container(
                      child: new Text("Priority Likes, see who likes you and more",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color:CommonColors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.only(top: 10,bottom: 15),
                child: Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          child: new Text("Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                        ),
                        new SizedBox(width: 13,),
                        Container(
                            decoration: BoxDecoration(
                              color: CommonColors.white,
                              borderRadius: BorderRadius.circular(65),
                            ),
                            // padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
                            alignment: Alignment.center,
                            width:69,
                            height:26,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Gold",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black),),
                              ],
                            )
                        ),
                      ],
                    ),
                    new SizedBox(height: 12,),
                    new Container(
                      child: new Text("Priority Likes, see who likes you and more",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color:CommonColors.buttonorg,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                padding: const EdgeInsets.only(top: 10,bottom: 15),
                child: Column(
                  children: [
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Container(
                          child: new Text("Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                        ),
                        new SizedBox(width: 13,),
                        Container(
                            decoration: BoxDecoration(
                              color: CommonColors.white,
                              borderRadius: BorderRadius.circular(65),
                            ),
                            // padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 0),
                            alignment: Alignment.center,
                            width:69,
                            height:26,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("VIP",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w600,color: Colors.black),),
                              ],
                            )
                        ),
                      ],
                    ),
                    new SizedBox(height: 12,),
                    new Container(
                      child: new Text("Priority Likes, see who likes you and more",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
                    ),
                  ],
                ),
              ),
              new SizedBox(height: 100,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                alignment: Alignment.centerLeft,
                child: new Text("Account Settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 25,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color: CommonColors.editblack,
                  borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Phone Number",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                      child: new Text(phone,style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 20,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                  color: CommonColors.editblack,
                  borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Email",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                      child: new Text(email,style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 30,right: 30,top:10),
                alignment: Alignment.centerLeft,
                child: new Text("Verify your phone number and email to help secure your account.",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),

              new SizedBox(height: 50,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Restore Account",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                      child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 50,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                alignment: Alignment.centerLeft,
                child: new Text("Search Settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 40,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.blueloc,
                    borderRadius: BorderRadius.circular(17)
                ),
                padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 30),
                child: Column(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      alignment:Alignment.centerLeft,
                      child: new Text("Location",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    new SizedBox(height: 20,),
                    Row(
                      children: [
                        new Container(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: Image.asset("assets/s_location.png"),
                            )
                        ),
                        new SizedBox(width: 10,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          child: new Text("Add country or continent",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: CommonColors.edittextblack),),
                        ),
                      ],
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 25,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Select",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 30,right: 30,top:10),
                alignment: Alignment.centerLeft,
                child: new Text("Change your location to see matches worldwide",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),
              new SizedBox(height: 21,),
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("GoGlobal",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                   Transform.scale(
                     scale:0.8,
                        child: CupertinoSwitch(
                          value:GoGlobal,
                          onChanged: (value){
                            GoGlobal = value;
                            setState(() {
                            });
                          },
                          thumbColor: CupertinoColors.black,
                          activeColor: CupertinoColors.white,
                          trackColor: CupertinoColors.white,
                        ),
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new Container(
                margin: const EdgeInsets.only(left: 30,right: 30,top:10),
                alignment: Alignment.centerLeft,
                child: new Text("Going global will allow you to see matches from around the world.",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),

              new SizedBox(height: 15,),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(17)
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // new SizedBox(width: 20,),
                        new Container(
                          child: new Text("Age range",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                        ),
                        Spacer(),
                        new Container(
                          child: new Text("${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round().toString()}",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                        ),
                        // new SizedBox(width: 20,),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RangeSlider(
                            values: _currentRangeValues,
                            max: 100,
                            min: 18,
                            divisions: 100,
                            inactiveColor: CommonColors.white,
                            activeColor: CommonColors.blueloc,
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),


              new SizedBox(height: 28,),
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(37)
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Only show people in this range",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                   Transform.scale(
                     scale:0.8,
                      child: CupertinoSwitch(
                        value:GoGlobal,
                        onChanged: (value){
                          GoGlobal = value;
                          setState(() {
                          });
                        },
                        thumbColor: CupertinoColors.black,
                        activeColor: CupertinoColors.white,
                        trackColor: CupertinoColors.white,
                      ),
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),


              new SizedBox(height: 15,),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(
                    color: CommonColors.editblack,
                    borderRadius: BorderRadius.circular(17)
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // new SizedBox(width: 20,),
                        new Container(
                          child: new Text("Height range",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                        ),
                        Spacer(),
                        new Container(
                          child: new Text("${_currentheightValues.start.toString().replaceAll(".","'")} - ${_currentheightValues.end.toString().replaceAll(".","'")}",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                        ),
                        // new SizedBox(width: 20,),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RangeSlider(
                            values: _currentheightValues,
                            max: 10,
                            min: 0,
                            divisions: 10,
                            inactiveColor: CommonColors.white,
                            activeColor: CommonColors.blueloc,
                            labels: RangeLabels(
                              _currentheightValues.start.toString().replaceAll(".","'"),
                              _currentheightValues.end.toString().replaceAll(".","'"),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentheightValues = values;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              new SizedBox(height: 32,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                alignment: Alignment.centerLeft,
                child: new Text("My visibility",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),

              new SizedBox(height: 22,),

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                // padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Show me on Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    ischeck ? InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=false;
                        });
                      },
                      child: new Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: CommonColors.blueloc,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=true;
                        });
                      },
                    child: new Container(
                      height: 20,
                        width: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)
                      ),
                    ),)
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 10),
                alignment: Alignment.centerLeft,
                child: new Text("Your profile will be seen in the card stack",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),

              new Container(
                height: 1,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 37,right: 37,top: 15),
              ),

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 20),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                // padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Go Incognito",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    ischeck ? InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=false;
                        });
                      },
                      child: new Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: CommonColors.blueloc,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=true;
                        });
                      },
                      child: new Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)
                        ),
                      ),)
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 10),
                alignment: Alignment.centerLeft,
                child: new Text("You will only be seen by people you like",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),


              Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 20),
                alignment:Alignment.centerLeft,
                child: new SizedBox(
                  height:24,
                  width:27,
                  child: Image.asset("assets/not_eye.png",height:24,width:27),
                ),
              ),

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 20),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                // padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Don’t show me on Shadi-App",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    ischeck ? InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=false;
                        });
                      },
                      child: new Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: CommonColors.blueloc,
                            borderRadius: BorderRadius.circular(3)
                        ),
                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                      ),
                    ):
                    InkWell(
                      onTap: (){
                        setState(() {
                          ischeck=true;
                        });
                      },
                      child: new Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(3)
                        ),
                      ),)
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 10),
                alignment: Alignment.centerLeft,
                child: new Text("Your profile won’t be shown in the card stack. You can still be seen by your matches",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),



              new SizedBox(height: 40,),
              Container(
                height: 50.0,
                margin: const EdgeInsets.only(left: 20,right: 20),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Show me online",style: new TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                   Transform.scale(
                     scale:0.8,
                      child: CupertinoSwitch(
                        value:GoGlobal,
                        onChanged: (value){
                          GoGlobal = value;
                          setState(() {
                          });
                        },
                        thumbColor: CupertinoColors.black,
                        activeColor: CupertinoColors.white,
                        trackColor: CupertinoColors.white,
                      ),
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new SizedBox(height: 15,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Select your username",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 20,),

              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  controller: tagsearch,
                  decoration: InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                      hintStyle: new TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                  style: new TextStyle(color: Colors.black,fontSize: 14),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Tag';
                    }
                    return null;
                  },
                ),
              ),
              new SizedBox(height: 40,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 100),
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
                              child: Text("Check availability", style: TextStyle(
                                  color: Colors.white, fontSize: 14,fontWeight: FontWeight.w400),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pushNamed("EnableLocation");
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

              new Container(
                margin: const EdgeInsets.only(left: 37,right: 37,top: 12),
                alignment: Alignment.centerLeft,
                child: new Text("Create a unique username. Use your username instead of your fullname.",style: new TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: Colors.white.withOpacity(0.6)),),
              ),

              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 23,right: 23),
                alignment: Alignment.centerLeft,
                child: new Text("App settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Notifications",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 15,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Email",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new SizedBox(height: 15,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Push notifications",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),


              new SizedBox(height: 40,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 25),
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
                              child: Text("Share Shadi-App", style: TextStyle(
                                  color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pushNamed("EnableLocation");
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




              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 23,right: 23),
                alignment: Alignment.centerLeft,
                child: new Text("Privacy",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Cookie Policy",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 15,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Privacy Policy",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),

              new SizedBox(height: 15,),
              new Container(
                margin: const EdgeInsets.only(left: 20,right: 30),
                // decoration: BoxDecoration(
                //     color: CommonColors.editblack,
                //     borderRadius: BorderRadius.circular(37)
                // ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // new SizedBox(width: 20,),
                    new Container(
                      child: new Text("Privacy preferences",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.edittextblack),),
                    ),
                    Spacer(),
                    new Container(
                        child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                    ),
                    // new SizedBox(width: 20,),
                  ],
                ),
              ),
              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 23,right: 23),
                alignment: Alignment.centerLeft,
                child: new Text("Privacy",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 25,),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: CommonColors.editblack,
                  // border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                alignment: Alignment.centerLeft,
                child: Text("Terms of Services",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.editblackgrey),textAlign: TextAlign.left,)
              ),
              new SizedBox(height: 30,),
              new Container(
                margin: const EdgeInsets.only(left: 23,right: 23),
                alignment: Alignment.centerLeft,
                child: new Text("Contact us",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
              ),
              new SizedBox(height: 25,),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: CommonColors.editblack,
                  // border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                alignment: Alignment.centerLeft,
                child: Text("Support",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.editblackgrey),textAlign: TextAlign.left,)
              ),

              new SizedBox(height: 140,),
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
                              child: Text("RESTORE PURCHASE", style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pushNamed("EnableLocation");
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
              new SizedBox(height: 20,),
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
                              child: Text("Update Setting".toUpperCase(), style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),),
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
              new SizedBox(height: 20,),
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
                              child: Text("LOGOUT", style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          navigateUser(context);
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
              new SizedBox(height: 20,),
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
                              child: Text("DELETE PROFILE", style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w900),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pushNamed("EnableLocation");
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

              new SizedBox(height: 100,),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: (){

                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/facebook.png"),
                      ),
                      splashColor: Colors.blue.withOpacity(0.2),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ),
                  new SizedBox(width: 35,),
                  new SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: (){

                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/twitter.png"),
                      ),
                      splashColor: Colors.blue.withOpacity(0.2),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ),
                  new SizedBox(width: 35,),
                  new SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: (){

                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/instagram.png"),
                      ),
                      splashColor: Colors.blue.withOpacity(0.2),
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ),
                ],
              ),

              new SizedBox(height: 100,),
            ],
          ),
        ),
      ),
    );
  }
}

