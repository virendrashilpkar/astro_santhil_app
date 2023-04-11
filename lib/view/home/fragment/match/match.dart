import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class Match extends StatefulWidget {
  @override
  State<Match> createState() => _MatchState();

}

class _MatchState extends State<Match> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          margin: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset("assets/gold_star.png"),
                  ),
                  Container(
                    child: Image.asset("assets/gold_star.png"),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(60.0)
                    ),
                    border: Border.all(
                        color: CommonColors.buttonorg,
                        width: 3.0)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Image.asset("assets/match_female.png",
                        width: 100,),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Image.asset("assets/match_male.png",
                          width: 100,),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Text("CONGRATS IT'S",
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text("A MATCH",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 5.0, left: 5.0),
                          alignment: Alignment.center,
                          child: TextFormField(
                            // controller: mobileNumber,
                            maxLength: 10,
                            keyboardType: TextInputType
                                .phone,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                counterText: "",
                                hintText: "send a message"
                            ),
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(top: 95,right: 50,left: 50),
                // margin: const EdgeInsets.symmetric(horizontal: 20),
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
                              child: Text("Keep swiping", style: TextStyle(
                                  color: Colors.white, fontSize: 20),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          Navigator.of(context).pushNamed('CountryCity');
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
      ),
    );
  }

}