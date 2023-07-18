import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shadiapp/CommonMethod/ConnectivityProvider.dart';
import 'package:shadiapp/CommonMethod/NoInternetPage.dart';
import 'package:shadiapp/CommonMethod/UnderConstructionPage.dart';
import 'package:shadiapp/view/ChooseReg/ChooseReg.dart';
import 'package:shadiapp/view/PhoneLogin/PhoneLogin.dart';
import 'package:shadiapp/view/accountrecover/AccountRecover.dart';
import 'package:shadiapp/view/addphotos/AddPhotos.dart';
import 'package:shadiapp/view/cast/cast.dart';
import 'package:shadiapp/view/countrycity/CountryCity.dart';
import 'package:shadiapp/view/enablelocation/EnableLocation.dart';
import 'package:shadiapp/view/forgotpassword/ForgotPassword.dart';
import 'package:shadiapp/view/heightweight/HeightWeight.dart';
import 'package:shadiapp/view/home/Home.dart';
import 'package:shadiapp/view/home/fragment/match/MatchPro.dart';
import 'package:shadiapp/view/home/fragment/profile/EditProfile.dart';
import 'package:shadiapp/view/intrests/Intrests.dart';
import 'package:shadiapp/view/lookingfor/LookingFor.dart';
import 'package:shadiapp/view/namedob/NameDOB.dart';
import 'package:shadiapp/view/otpverify/OTPVerify.dart';
import 'package:shadiapp/view/problemauth/ProblemAuth.dart';
import 'package:shadiapp/view/setting/Settings.dart';
import 'package:shadiapp/view/subscription/GoldSub.dart';
import 'package:shadiapp/view/subscription/PremiumSub.dart';
import 'package:shadiapp/view/subscription/VIPSub.dart';
import 'package:shadiapp/view/subscription/freeSub.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {

      // bool isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
      //
      // if(!isOnline){
      //   return NoInternetPage();
      // }

      switch (settings.name) {
        case "ChooseReg":
        // ignore: prefer_const_constructors
          return ChooseReg();
        case "AccountRecover":
        // ignore: prefer_const_constructors
          return AccountRecover();
        case "PhoneLogin":
        // ignore: prefer_const_constructors
          return PhoneLogin();
        case "ProblemAuth":
        // ignore: prefer_const_constructors
          return ProblemAuth();
        case "OTPVerify":
        // ignore: prefer_const_constructors
          return OTPVerify("");
        case "ForgotPassword":
        // ignore: prefer_const_constructors
          return ForgotPassword();
        case "CountryCity":
        // ignore: prefer_const_constructors
          return CountryCity();
        case "Caste":
        // ignore: prefer_const_constructors
          return Cast();
        case "NameDOB":
        // ignore: prefer_const_constructors
          return NameDOB();
        case "HeightWeight":
        // ignore: prefer_const_constructors
          return HeightWeight();
        case "LookingFor":
        // ignore: prefer_const_constructors
          return LookingFor();
        case "AddPhotos":
        // ignore: prefer_const_constructors
          return AddPhotos();
        case "Intrests":
        // ignore: prefer_const_constructors
          return Intrests();
        case "EnableLocation":
        // ignore: prefer_const_constructors
          return EnableLocation();
        case "Home":
        // ignore: prefer_const_constructors
          return Home();
        case "MatchPro":
        // ignore: prefer_const_constructors
          return MatchPro();
        case "Settings":
        // ignore: prefer_const_constructors
          return Settings();
        case "EditProfile":
        // ignore: prefer_const_constructors
          return EditProfile();
        case "FreeSub":
        // ignore: prefer_const_constructors
          return FreeSub();
        case "PremiumSub":
        // ignore: prefer_const_constructors
          return PremiumSub("", 0, []);
        case "GoldSub":
        // ignore: prefer_const_constructors
          return GoldSub("", 0, []);
        case "VIPSub":
        // ignore: prefer_const_constructors
          return VIPSub("", 0, []);

      }
      // ignore: prefer_const_constructors
      return UnderConstructionPage();
    });
  }
}