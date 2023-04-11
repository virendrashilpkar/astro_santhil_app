import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
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

  @override
  void initState() {
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
  TextEditingController tagsearch = TextEditingController();
  RangeValues _currentRangeValues = const RangeValues(18, 29);
  RangeValues _currentheightValues = const RangeValues(0, 10);

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
                            padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
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
                            padding: const EdgeInsets.symmetric(horizontal: 23,vertical: 4),
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
                child: new Text("Account Settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.6)),),
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
                      child: new Text("8801640630118",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
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
                      child: new Text("Sofia@gmail.com",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
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
                child: new Text("Search Settings",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.6)),),
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
                    new Container(
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
                    new Container(
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
                child: new Text("My visibility",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white.withOpacity(0.6)),),
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
                  height:25,
                  width:25,
                  child: Image.asset("assets/not_eye.png",height:25,width:25),
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
                    new Container(
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
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              child: Text("Continue", style: TextStyle(
                                  color: Colors.white, fontSize: 20),),
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
              new SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}

