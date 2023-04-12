import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/StarRating.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/view/home/fragment/homesearch/Content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Profile> {

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
  late double _scrollPosition;
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    CheckUserConnection();
    super.initState();
  }
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }
  int currentIndex=0;
  List<Color> colorList=[CommonColors.buttonorg,CommonColors.yellow,CommonColors.bluepro];
  List<String> packagetittle=["Premium","Gold","VIP"];
  List<String> packagedis=["20","25","30"];
  List<Color> colorList2=[CommonColors.buttonorg,CommonColors.yellow];
  List<String> packagetittle2=["Premium","Gold"];
  List<String> packagedis2=["20","25"];

  int parcasepackage=100;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              children: [
                new SizedBox(
                  height: 15,
                ),
                new Container(
                  child: Row(
                    children: [
                      new Spacer(),
                      new SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset("assets/shield_pro.png",height:24,width: 20,),
                      ),
                      new SizedBox(
                        width: 24,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed("Settings");
                        },
                        child: new SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset("assets/setting_pro.png",height:24,width: 20,color: Colors.white,),
                        ),
                      ),
                      new SizedBox(
                        width: 24,
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  height:180,
                  width: 180,
                  child: Stack(
                    children: [
                      new Positioned(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(90.0),
                            child: Image.network("https://w0.peakpx.com/wallpaper/509/744/HD-wallpaper-jisoo-blackpink-cute-k-pop-love-music.jpg",fit: BoxFit.cover,height: 180,width: 180,),
                          )
                      ),
                      new Positioned(
                        bottom: 15,
                          right: 15,
                          child: InkWell(
                            onTap: (){
                              
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: 28,
                                width: 28,
                                padding: const EdgeInsets.all(5),
                                color: Colors.white,
                                child: Icon(Icons.camera_alt,color: Colors.black,
                                size: 15,),
                              )
                            ),
                          )
                      )
                    ],
                  )
                ),
                new SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      child: Text("Noor Jahan",style: new TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color:Colors.white),),
                    ),
                    new SizedBox(width: 5,),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/blue_tick.png",height: 25,width: 25,),
                    )
                  ],
                ),
                new SizedBox(height: 5,),
                new Container(
                  child: Text("Copenhagen, Denmark",style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color:Colors.white.withOpacity(0.6)),),
                ),
                new SizedBox(height: 15,),
                Container(
                  height: 50,
                  // margin: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.symmetric(horizontal: 100),
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Edit Profile", style: TextStyle(
                                        color: Colors.white, fontSize: 16,fontWeight: FontWeight.w700),),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      SizedBox.expand(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(onTap: () {
                            Navigator.of(context).pushNamed("EditProfile");
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
                new SizedBox(height: 18,),
                if(packagetittle.length >= parcasepackage) new Container(
                  child: Text("You have Premium membership",style: new TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color:Colors.white),),
                ),
                if(packagetittle.length >= parcasepackage) new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  alignment: Alignment.center,
                  child: Text("Upgrade NOW and be more succesful 3 MONTHS  PROMOTION",style: new TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color:Colors.white),textAlign: TextAlign.center,),
                ),

                packagetittle.length >= parcasepackage ? new Container(
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: packagetittle2.length,
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemBuilder: (ctx,index){
                          return  InkWell(
                            onTap: (){
                              setState(() {
                                parcasepackage=100;
                              });
                            },
                            child: new Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.width/2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/3.5,
                                      height: MediaQuery.of(context).size.width/2-50,
                                      decoration: BoxDecoration(
                                        color:colorList2[index],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0) //                 <--- border radius here
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          new SizedBox(
                                            height: 47,
                                            width: 36,
                                            child: Image.asset("assets/drop_pro.png"),
                                          ),
                                          new SizedBox(height: 5,),
                                          new Container(
                                            child: Text("${packagetittle2[index]}",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                                          ),
                                          new SizedBox(height: 5,),
                                          new Container(
                                            child: Text("\$ 175.00",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ) :
                new Container(
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: packagetittle.length,
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemBuilder: (ctx,index){
                          return index!=parcasepackage ? InkWell(
                            onTap: (){
                              setState(() {
                                parcasepackage=index;
                                currentIndex=index;
                              });
                            },
                            child: new Container(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.width/2,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/3.5,
                                      height: MediaQuery.of(context).size.width/2-50,
                                      decoration: BoxDecoration(
                                        color:colorList[index],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0) //                 <--- border radius here
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          new SizedBox(
                                            height: 47,
                                            width: 36,
                                            child: Image.asset("assets/drop_pro.png"),
                                          ),
                                          new SizedBox(height: 10,),
                                          new Container(
                                            child: Text("${packagetittle[index]}",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                        margin: const EdgeInsets.only(right: 5,top:5),
                                        decoration: BoxDecoration(
                                          color: CommonColors.red,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text("Save ${packagedis[index]}%",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w700,color: Colors.white),),
                                          ],
                                        )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ):Container();
                        },
                      )
                    ],
                  ),
                ),
                new SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i = 0; i < packagedis.length; i++)
                        Container(
                            height: 10, width: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                color: i == currentIndex ?  CommonColors.buttonorg:Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            )
                        )
                    ]
                ),
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 5),
                //   child: new Row(
                //     children: [
                //       Expanded(
                //         child: new Container(
                //           width: double.maxFinite,
                //           height: MediaQuery.of(context).size.width/2,
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Positioned(
                //                 bottom: 10,
                //                 child: Container(
                //                   width: MediaQuery.of(context).size.width/3.5,
                //                   height: MediaQuery.of(context).size.width/2-50,
                //                   decoration: BoxDecoration(
                //                     color:CommonColors.buttonorg,
                //                     borderRadius: BorderRadius.all(
                //                         Radius.circular(10.0) //                 <--- border radius here
                //                     ),
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       new SizedBox(
                //                         height: 47,
                //                         width: 36,
                //                         child: Image.asset("assets/drop_pro.png"),
                //                       ),
                //                       new SizedBox(height: 10,),
                //                       new Container(
                //                         child: Text("Premium",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 bottom: 0,
                //                 child: Container(
                //                     margin: const EdgeInsets.only(right: 5,top:5),
                //                     decoration: BoxDecoration(
                //                       color: CommonColors.red,
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                //                     child: Row(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         Text("Save 25%",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w700,color: Colors.white),),
                //                       ],
                //                     )
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: new Container(
                //           width: double.maxFinite,
                //           height: MediaQuery.of(context).size.width/2,
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Positioned(
                //                 bottom: 10,
                //                 child: Container(
                //                   width: MediaQuery.of(context).size.width/3.5,
                //                   height: MediaQuery.of(context).size.width/2-50,
                //                   decoration: BoxDecoration(
                //                     color:CommonColors.yellow,
                //                     borderRadius: BorderRadius.all(
                //                         Radius.circular(10.0) //                 <--- border radius here
                //                     ),
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       new SizedBox(
                //                         height: 47,
                //                         width: 36,
                //                         child: Image.asset("assets/drop_pro.png"),
                //                       ),
                //                       new SizedBox(height: 10,),
                //                       new Container(
                //                         child: Text("Gold",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 bottom: 0,
                //                 child: Container(
                //                     margin: const EdgeInsets.only(right: 5,top:5),
                //                     decoration: BoxDecoration(
                //                       color: CommonColors.red,
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                //                     child: Row(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         Text("Save 25%",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w700,color: Colors.white),),
                //                       ],
                //                     )
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: new Container(
                //           width: double.maxFinite,
                //           height: MediaQuery.of(context).size.width/2,
                //           child: Stack(
                //             alignment: Alignment.center,
                //             children: [
                //               Positioned(
                //                 bottom: 10,
                //                 child: Container(
                //                   width: MediaQuery.of(context).size.width/3.5,
                //                   height: MediaQuery.of(context).size.width/2-50,
                //                   decoration: BoxDecoration(
                //                     color:CommonColors.bluepro,
                //                     borderRadius: BorderRadius.all(
                //                         Radius.circular(10.0) //                 <--- border radius here
                //                     ),
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       new SizedBox(
                //                         height: 47,
                //                         width: 36,
                //                         child: Image.asset("assets/drop_pro.png"),
                //                       ),
                //                       new SizedBox(height: 10,),
                //                       new Container(
                //                         child: Text("VIP",style: new TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                //                       )
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Positioned(
                //                 bottom: 0,
                //                 child: Container(
                //                     margin: const EdgeInsets.only(right: 5,top:5),
                //                     decoration: BoxDecoration(
                //                       color: CommonColors.red,
                //                       borderRadius: BorderRadius.circular(5),
                //                     ),
                //                     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                //                     child: Row(
                //                       mainAxisSize: MainAxisSize.min,
                //                       children: [
                //                         Text("Save 25%",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w700,color: Colors.white),),
                //                       ],
                //                     )
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                new SizedBox(height: 15,),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 50,left: 50),
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
                                child: Text("Upgrade NOW", style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                              )),
                        ],
                      ),
                      SizedBox.expand(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(onTap: () {
                            Navigator.of(context).pushNamed('MatchPro');
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
            )
        ),
      )
    );
  }
}