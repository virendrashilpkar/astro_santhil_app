import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';


class Intrests extends StatefulWidget {
  @override
  State<Intrests> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Intrests> {

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
  // List<File?> imagelist=[null,null,null,null,null,null];

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

  TextEditingController tagsearch = TextEditingController();
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
              new SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 20,right: 55),
                child: Text(
                  'How would you describe yourself? select 4',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              new SizedBox(height: 20,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  controller: tagsearch,
                  decoration: InputDecoration(
                    hintText: 'Add New Tag...',
                    border: InputBorder.none,
                    hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                    prefixIcon: SizedBox(child: Image.asset("assets/tag_intrests.png"),),
                    suffixIcon: new InkWell(
                      onTap: (){
                          if(selectedIndex.length!=4){
                            setState((){
                            tags.add(tagsearch.text!);
                            selectedIndex.add(tags.length-1);
                            });
                          }else{
                            Toaster.show(context, "You can select only 4");
                          }
                      },
                      child: SizedBox(child: Icon(Icons.done,color: Colors.cyan,),),
                    )
                  ),
                  style: new TextStyle(color: Colors.white,fontSize: 14),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Tag';
                    }
                    return null;
                  },
                ),
              ),
              new SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 17),
                alignment: Alignment.centerLeft,
                child: Wrap(
                  children: [
                    ...List.generate(
                      tags.length,
                          (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            if(selectedIndex.length!=4){
                              selectedIndex.add(index);
                            }else{
                              Toaster.show(context, "You can select only 4");
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            color: selectedIndex.contains(index) ? CommonColors.buttonorg : null,
                            borderRadius: BorderRadius.circular(65),
                          ),
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${tags[index]}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                              new SizedBox(width: 5,),
                              new SizedBox(
                                child: InkWell(onTap: (){
                                  setState(() {
                                    selectedIndex.remove(index);
                                  });
                                },child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Icon(Icons.close,color: Colors.white,),
                                )),
                              )
                            ],
                          )
                        ),
                      ),
                    )
                  ],
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
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
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

