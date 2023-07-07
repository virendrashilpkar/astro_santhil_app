import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/Models/matchlist.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/home/fragment/chats/ChatRoom.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shadiapp/Services/Services.dart';



class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}
class _ChatState extends State <Chat> {
  var images = [
    "https://w0.peakpx.com/wallpaper/564/224/HD-wallpaper-beautiful-girl-bengali-eyes-holi-indian.jpg",
    "https://w0.peakpx.com/wallpaper/396/511/HD-wallpaper-bong-angel-bengali.jpg",
    "https://w0.peakpx.com/wallpaper/798/474/HD-wallpaper-beauty-123-beautiful-ivana-saree.jpg",
    "https://w0.peakpx.com/wallpaper/366/237/HD-wallpaper-vaishnavi-beautiful-saree.jpg",
    "https://w0.peakpx.com/wallpaper/233/819/HD-wallpaper-vaishnavi-shanu-short-film-software-developer.jpg",
    "https://w0.peakpx.com/wallpaper/344/1000/HD-wallpaper-ashika-ranganath-saree-lover-model.jpg",
    "https://w0.peakpx.com/wallpaper/280/777/HD-wallpaper-anju-kurien-mallu-actress-saree-lover.jpg",
    "https://w0.peakpx.com/wallpaper/373/1013/HD-wallpaper-anju-32-actress-girl-mallu-anju-kurian.jpg",
    "https://w0.peakpx.com/wallpaper/306/75/HD-wallpaper-anju-kurian-babu-suren.jpg",
    "https://w0.peakpx.com/wallpaper/504/652/HD-wallpaper-anju-kurian-anju-kurian-mallu.jpg",
    "https://w0.peakpx.com/wallpaper/290/185/HD-wallpaper-anju-kurian-flash-graphy-lip.jpg",
    "https://w0.peakpx.com/wallpaper/320/566/HD-wallpaper-jisoo-jisoo-blackpink.jpg",
    "https://w0.peakpx.com/wallpaper/862/303/HD-wallpaper-jisoo-blackpink-blackpink-jisoo-k-pop.jpg",
    "https://w0.peakpx.com/wallpaper/509/744/HD-wallpaper-jisoo-blackpink-cute-k-pop-love-music.jpg",
  ];



  @override
  void initState() {
    super.initState();
    getAvailableuser();
    Getmatch();
  }


  List OneList = [];
  bool isLoading = true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late SharedPreferences _preferences;
  String user_id="";

  bool isLoad=false;
  late MatchList matchList;
  List<Datum> _matchList=[];
  void Getmatch()async{
    isLoad = true;
    _preferences = await SharedPreferences.getInstance();
    matchList = await Services.MatchListMethod("${_preferences?.getString(ShadiApp.userId).toString()}");
    if(matchList.status == 200) {
      for(var i = 0; i < matchList.data!.length; i++){
        _matchList = matchList.data ?? <Datum> [];
      }
    }
    isLoad = false;
    setState(() {
    });
  }


  void getAvailableuser() async {

    _preferences = await SharedPreferences.getInstance();
    user_id = "${_preferences?.getString(ShadiApp.userId).toString()}";
    await _firestore
        .collection('chatroom')
        .get()
        .then((value) {
      print(value.docs);
      OneList = value.docs;
      isLoading = false;
      if(mounted) {
        setState(() {});
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      endDrawer: Drawer(
        width: 180,
        backgroundColor: CommonColors.matchDrawer,
    child: ListView(
    padding: EdgeInsets.zero,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 70.0),
          child: Text(
              'New Matches',
              style: new TextStyle(fontSize: 16.0, color: CommonColors.buttonorg),
              textAlign: TextAlign.center,
            ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
                  height: double.maxFinite,
                  child: ListView.builder(
                      itemCount: images.length,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, i) {
                        return new ListTile(
                          title: new Container(
                            width: 120,
                            height: 150,
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)),
                              color: CommonColors.bottomgrey,
                            ),
                            child:
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(images[i],
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                        );
                      }
                  )
              ),
          ),
        )
      ],
    ),
    ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new SizedBox(height: MediaQuery.of(context).padding.top+20,),
            new Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 35.5,vertical: 0),
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: Image.asset(
                      'assets/shield_pro.png',
                      width: 20,
                      height: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 35),
                    child: Image.asset(
                      'assets/settings.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 35.0),
                child: Text("Likes you 45",
                  style: TextStyle(color: CommonColors.buttonorg),
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: 25.0, top: 10.0, right: 0.0, bottom: 10.0),
              height: 100,
              child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      padding: const EdgeInsets.all(2),
                      decoration: index==0 ? BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0)),
                        border: Border.all(color: Colors.yellow,width: 2)
                      ):null,
                      child: Container(
                        width: 80,
                        height: 97,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15.0)),
                          color: CommonColors.bottomgrey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                  fit: BoxFit.cover)
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Spacer(),
                                    Container(
                                      color: Colors.white30,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text("Ana, 24",
                                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Container(
                child:
                _matchList.isEmpty ?
                Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: Center(
                      child: Stack(
                        children: [
                          // Image.asset("assets/iconsnew/no_data_ic.png", width: MediaQuery.of(context).size.width / 1.5, height: MediaQuery.of(context).size.height / 2,),
                          Positioned(
                              bottom: 100,
                              left: 0,
                              right: 0,
                              child: Center(child: Text("There is no chat available", style: const TextStyle(fontSize: 16, fontFamily: 'dubai', color: Colors.black, fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
                          ),
                        ],
                      )
                  ),
                ) :
                ListView.builder(
                    itemCount: _matchList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                      // bool isvisible=false;
                      // String members= OneList[index]["uid1"];
                      // String members2= OneList[index]["uid2"];
                      // String membersn= OneList[index]["user1"];
                      // String membersn2= OneList[index]["user2"];
                      // String image1= OneList[index]["image1"];
                      // String image2= OneList[index]["image2"];
                      // String id= OneList[index]["id"];
                      // if(members==user_id || members2==user_id){
                      //   isvisible = true;
                      // }
                      return Container(
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              color: Colors.white30,
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ChatRoom(_matchList[index].image ?? "",_matchList[index].id ?? "",_matchList[index].id ?? "","${_matchList[index].firstName}${_matchList[index].lastName}")
                                    )
                                );
                              },
                              child: Container(
                                decoration:index==0 ? BoxDecoration(
                                  color: Color(0xff373737),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ):null,
                                margin: EdgeInsets.only(top: 2,bottom: 5),
                                padding: EdgeInsets.only(top: 10,bottom: 10,left: 35),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 62,
                                      child: CircleAvatar(
                                        radius: 31,
                                        backgroundImage: NetworkImage(_matchList[index].image ?? ""),
                                        backgroundColor: CommonColors.bottomgrey,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(left: 13.0),
                                              child: Text("${_matchList[index].firstName} ${_matchList[index].lastName}",
                                                style: TextStyle(
                                                  color: Colors.white, fontSize: 16,
                                                    fontWeight: FontWeight.w500, fontStyle: FontStyle.normal
                                                ),
                                              )
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 13.0),
                                          child: Text("Hi",
                                            style: TextStyle(
                                              color: Colors.white30, fontSize: 16,
                                                fontFamily: "OpenSans_Regular",
                                                fontWeight: FontWeight.w400, fontStyle: FontStyle.normal
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    index==0 ? Container(
                                      height: 26,
                                      width: 26,
                                      margin: EdgeInsets.only(right: 45.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                          color:CommonColors.themeblack
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("1",
                                          style: TextStyle(
                                              color: Color(0xffEF7D90), fontSize: 15,fontWeight: FontWeight.w400
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ):Container(
                                      alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only( right: 45.0,),
                                        child: Text("1h",
                                          style: TextStyle(
                                              color: Colors.white30, fontSize: 15,fontWeight: FontWeight.w400
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }

}