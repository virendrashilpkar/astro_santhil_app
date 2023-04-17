import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CountryCity extends StatefulWidget {
  @override
  State<CountryCity> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CountryCity> {

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

  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }
  String country = 'Select country';
  String city = 'Select city';
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
                  });
                },
                selectedItemBuilder: (BuildContext context) {
                  return ['Select country', 'india', 'pakistan', 'china'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:country == 'Select country' ? Colors.grey:  Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: <String>['Select country', 'india', 'pakistan', 'china'] // add your own dial codes
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
                  return ['Select city', 'indore', 'bhopal', 'guna'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,style: TextStyle(color:city == 'Select city' ? Colors.grey : Colors.white,fontSize: 16),),
                    );
                  }).toList();
                },
                iconSize: 24,
                icon: Icon(Icons.arrow_forward_ios),
                iconDisabledColor: Colors.white,
                items: <String>['Select city', 'indore', 'bhopal', 'guna'] // add your own dial codes
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
                        Navigator.of(context).pushNamed('NameDOB');
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

