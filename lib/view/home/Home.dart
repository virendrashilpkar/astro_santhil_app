import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/CommonMethod/commonString.dart';
import 'package:shadiapp/view/home/fragment/homesearch/HomeSearch.dart';
import 'package:shadiapp/view/home/fragment/likes/LikesSent.dart';
import 'package:shadiapp/view/home/fragment/live/Live.dart';
import 'package:shadiapp/view/home/fragment/profile/Profile.dart';

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


  int backButtonPressedCount = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeSearch(),
      Live(),
      LikesSent(),
      Chat(),
      Profile(isback:false)
    ];
    return WillPopScope(
      onWillPop: () async {
        if (backButtonPressedCount == 0) {
          backButtonPressedCount++;
          Toaster.show(context, "Press back again to exit");
          return false;
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: CommonColors.themeblack,
        bottomNavigationBar: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          margin:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          decoration: BoxDecoration(
            color: CommonColors.themeblack,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                // enableFeedback: false,
                onTap: () {
                  setState(() {
                    CommonString.homesearch = "";
                    pageIndex = 0;
                  });
                },
                child: Container(
                  height: 40,width: 25,
                  alignment: Alignment.topCenter,
                  child: pageIndex == 0
                      ? Image.asset("assets/home_search.png",color: CommonColors.buttonorg,height: 40,width: 25,)
                      : Image.asset("assets/home_search.png",color: CommonColors.bottomgrey,height: 40,width: 25,),
                )
              ),
              InkWell(
                // enableFeedback: false,
                  onTap: () {
                  setState(() {
                    CommonString.homesearch = "";
                    pageIndex = 1;
                  });
                },
                  child: Container(
                    height: 40,width: 25,
                    alignment: Alignment.topCenter,
                    child: pageIndex == 1
                      ? Image.asset("assets/home_live.png",height: 40,width: 25,)
                      : Image.asset("assets/home_live.png",height: 40,width: 25,),
                  )
              ),
              InkWell(
                // enableFeedback: false,
                  onTap: () {
                  setState(() {
                    CommonString.homesearch = "";
                    pageIndex = 2;
                  });
                },
                  child: Container(
                  height: 40,width: 25,
                    alignment: Alignment.topCenter,
                    child: pageIndex == 2
                      ? Image.asset("assets/home_fav.png",color: CommonColors.buttonorg,height: 40,width: 25,)
                      : Image.asset("assets/home_fav.png",color: CommonColors.bottomgrey,height: 40,width: 25,),
                  )
              ),
              InkWell(
                // enableFeedback: false,
                  onTap: () {
                  setState(() {
                    CommonString.homesearch = "";
                    pageIndex = 3;
                  });
                },
                  child: Container(
                    height: 40,width: 25,
                    alignment: Alignment.topCenter,
                    child: pageIndex == 3
                      ? Image.asset("assets/home_chat.png",color: CommonColors.buttonorg,height: 40,width: 25,)
                      : Image.asset("assets/home_chat.png",color: CommonColors.bottomgrey,height: 40,width: 25,),
                  )
              ),
              InkWell(
                // enableFeedback: false,
                  onTap: () {
                  setState(() {
                    CommonString.homesearch = "";
                    pageIndex = 4;
                  });
                },
                  child: Container(
                    height: 40,width: 25,
                    alignment: Alignment.topCenter,
                    child: pageIndex == 4
                      ? Image.asset("assets/home_profile.png",color: CommonColors.buttonorg,height: 40,width: 25,)
                      : Image.asset("assets/home_profile.png",color: CommonColors.bottomgrey,height: 40,width: 25,),
                  )
              ),
            ],
          ),
        ),
        body: pages[pageIndex],
      ),
    );
  }
}

