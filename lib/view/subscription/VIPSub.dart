
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/view/subscription/custom/Customcheck.dart';

class VIPSub extends StatefulWidget {
  @override
  State<VIPSub> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VIPSub> {

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



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: SafeArea(
        child:  new Container(
          height:MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: CommonColors.buttonorg,
              // border: Border.all(width: 1,color: Colors.white),
              borderRadius: BorderRadius.circular(10)
          ),
          // color: CommonColors.bluepro,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Column(
            children: [
              InkWell(
                onTap:(){
                  Navigator.of(context).pop();
                },
                child: new Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1,color: Colors.white),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Image.asset("assets/home_close.png",color: Colors.white,)),),
                ),
              ),
              new Container(
                child: Text("Plan Comparison",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
              ),
              new Container(
                child: Text("Choose the best plan for you",style: new TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
              ),
              new Container(
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: CommonColors.freegrey,
                    // border: Border.all(width: 1,color: Colors.white),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    new SizedBox(height: 20,),
                    new Container(
                      child: Text("VIP",style: new TextStyle(color: CommonColors.black,fontSize: 20,fontWeight: FontWeight.w600),),
                    ),
                    new SizedBox(height: 5,),
                    new Container(
                      child: Text("Unlock all of our features to be in\ncomplete control of your experience",style: new TextStyle(color: CommonColors.themeblack,fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                    ),
                    new SizedBox(height: 5,),


                    InkWell(
                      onTap: (){

                      },
                      child: new Container(
                        // margin: const EdgeInsets.all(15),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 48),
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
                        decoration: BoxDecoration(
                            color: CommonColors.buttonorg,
                            // border: Border.all(width: 1,color: Colors.white),
                            borderRadius: BorderRadius.circular(54)
                        ),
                        child: Column(
                          children: [
                            new Container(
                              child: Text("Upgrade form \$19.27",style: new TextStyle(color: CommonColors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    new SizedBox(height: 20,),


                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(int i = 0; i < 3; i++)
                      Container(
                          height: 8, width: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          decoration: BoxDecoration(
                              color: i == 0 ?  CommonColors.buttonorg:Colors.white,
                              borderRadius: BorderRadius.circular(4)
                          )
                      )
                  ]
              ),

              new Expanded(
                  child:
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        new Customcheck(tittle: "Unlimited likes",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Record a voice message on profile",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Search Worldwide",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Unlimited Super likes daily",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Control what you want to show",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Only profiles you like can see you",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Select a username",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Upload videos",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "GoLive, videoconference with members",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Top Matches selected daily",color: CommonColors.white,textcolor: CommonColors.black,),
                        new Customcheck(tittle: "Message while liking",color: CommonColors.white,textcolor: CommonColors.black,),

                      ],
                    ),
                  )
              )


            ],
          ),
        )
      ),
    );
  }
}

