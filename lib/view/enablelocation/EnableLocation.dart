import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';


class EnableLocation extends StatefulWidget {
  @override
  State<EnableLocation> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EnableLocation> {

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


  void askPermission(BuildContext context)async{
    var status = await Permission.location.request();
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }else{
      Navigator.of(context).pushNamed("Home");
    }
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
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
              new SizedBox(height: 140,),

              Container(
                alignment: Alignment.center,
                child: Image.asset("assets/location.png",height: 180,width: 180,),
              ),
              new SizedBox(height: 68,),
              Container(
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(left: 20,right: 55),
                child: Text(
                  'Enable Location Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 120,),
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
                              child: Text("Allow", style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          askPermission(context);
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
              new SizedBox(height: 15,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: CommonColors.buttonorg,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Center(
                              child: Text("Decline", style: TextStyle(
                                  color: Colors.white.withOpacity(0.6), fontSize: 16,fontWeight: FontWeight.w400,),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Toaster.show(context, "Allow for batter experience");
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

