import 'package:astro_santhil_app/main.dart';
import 'package:astro_santhil_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  void navigateUser(BuildContext context) async{
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    _preferences.clear();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xff1BBF57),
                  Color(0xff34E389),
                ],)
          ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 100.0,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(top: 20.0, right: 20.0, ),
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => Home()),
                                  (route) => false);
                        },
                        child: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
              Container(
              child: CircleAvatar(
              radius: 50.0,
                backgroundColor: Colors.white,
                child: Container(
                    child: Image.asset("assets/green text-01.png",
                      width: 90,)),
              ),
        ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 20.0),
                    child: Text("Astro Senthil",
                      style: TextStyle(fontSize: 32.39, color: Colors.white, fontWeight: FontWeight.w700),),
                  ),
                  Container(
                    height: 1.0,
                    color: Color(0xff3CD6CE),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                    },
                    child: TAbBarr(text: "Home", icon: "assets/home_ic.png",),
                  ),
                  Container(
                    height: 1.0,
                    color: Color(0xff3CD6CE),
                  ),
                  InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: "Coming soon");
                    },
                    child: TAbBarr(text: "My profile", icon: "assets/adim_ic.png",),
                  ),
                  Container(
                    height: 1.0,
                    color: Color(0xff3CD6CE),
                  ),
                  InkWell(
                    onTap: () {
                      navigateUser(context);
                    },
                    child: TAbBarr(text: "Log Out", icon: "assets/turn_off.png",),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}

class TAbBarr extends StatelessWidget {
  String text;
  String icon;
  TAbBarr({required this.text,required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset("$icon",
              color:Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
              "$text",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20, color: Colors.white,
              fontWeight: FontWeight.w600)
          ),
          Spacer(),
        ],
      ),
    );
  }
}
