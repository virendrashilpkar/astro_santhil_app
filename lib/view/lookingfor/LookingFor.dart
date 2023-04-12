import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class LookingFor extends StatefulWidget {
  @override
  State<LookingFor> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LookingFor> {

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
  String lookingvalue="";
  String martialstatus="Martial status";
  List<String> maritalStatuses = [
    'Martial status',
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];
  List<String> youarea=["Man","Woman"];
  List<String> lookingfor=["Woman","Man","Both"];

  @override
  void initState() {
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
                  'My martial status is',
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
                  value: martialstatus,
                  underline: Container(
                    // height: 1,
                    // margin:const EdgeInsets.only(top: 20),
                    // color: Colors.white,
                  ),
                  isExpanded: true,
                  style: TextStyle(color: Colors.white,fontSize: 16),
                  onChanged: (newValue) {
                    setState(() {
                      martialstatus = newValue!;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return maritalStatuses.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style: TextStyle(color:martialstatus=="Martial status" ? Colors.grey : Colors.white,fontSize: 16),),
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
                          Navigator.of(context).pushNamed('AddPhotos');
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

