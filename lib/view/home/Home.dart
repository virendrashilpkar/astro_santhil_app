import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/view/addphotos/AddPhotos.dart';
import 'package:shadiapp/view/enablelocation/EnableLocation.dart';
import 'package:shadiapp/view/forgotpassword/ForgotPassword.dart';
import 'package:shadiapp/view/heightweight/HeightWeight.dart';
import 'package:shadiapp/view/home/fragment/homesearch/HomeSearch.dart';
import 'package:shadiapp/view/home/fragment/likes/LikesSent.dart';
import 'package:shadiapp/view/home/fragment/profile/Profile.dart';
import 'package:shadiapp/view/otpverify/OTPVerify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';

import 'fragment/chats/chat.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {

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

  int pageIndex = 0;

  final pages = [
    HomeSearch(),
    OTPVerify(),
    LikesSent(),
    Chat(),
    Profile()
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: CommonColors.themeblack,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? Image.asset("assets/home_search.png",color: CommonColors.buttonorg,height: 20,width: 20,)
                  : Image.asset("assets/home_search.png",color: CommonColors.bottomgrey,height: 20,width: 20,)
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? Image.asset("assets/home_live.png",color: CommonColors.buttonorg,height: 20,width: 20,)
                  : Image.asset("assets/home_live.png",color: CommonColors.bottomgrey,height: 20,width: 20,)
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? Image.asset("assets/home_fav.png",color: CommonColors.buttonorg,height: 20,width: 20,)
                  : Image.asset("assets/home_fav.png",color: CommonColors.bottomgrey,height: 20,width: 20,)
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? Image.asset("assets/home_chat.png",color: CommonColors.buttonorg,height: 20,width: 20,)
                  : Image.asset("assets/home_chat.png",color: CommonColors.bottomgrey,height: 20,width: 20,)
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 4;
                });
              },
              icon: pageIndex == 4
                  ? Image.asset("assets/home_profile.png",color: CommonColors.buttonorg,height: 20,width: 20,)
                  : Image.asset("assets/home_profile.png",color: CommonColors.bottomgrey,height: 20,width: 20,)
            ),
          ],
        ),
      ),
      body: pages[pageIndex],
    );
  }
}

