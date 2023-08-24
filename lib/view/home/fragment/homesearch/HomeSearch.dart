import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/StarRating.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/CommonMethod/commonString.dart';
import 'package:shadiapp/Models/like_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_list_model.dart';
import 'package:shadiapp/Models/user_view_preference_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/home/fragment/homesearch/Content.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayout.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayoutview.dart';
import 'package:shadiapp/view/home/fragment/match/Match.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSearch extends StatefulWidget {
  @override
  State<HomeSearch> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeSearch> {

  bool ActiveConnection = false;
  String T = "";
  SharedPreferences? _preferences;
  late UserListModel _userListModel;
  late UserViewPreferenceModel _viewPreferenceModel;
  late LikeModel _likeModel;
  late UserDetailModel _userDetailModel = UserDetailModel();
  late PersistentBottomSheetController _bottomSheetController; // instance variable
  List<UserDatum> _userList = [];
  List<PrefsDatum> intrest = [];
  bool clickLoad = false;
  bool isLoad = false;

  String name = "";
  String lastName = "";
  String age = "";
  String place = "";
  String country = "";
  String height = "";
  String weight = "";
  String religion = "";
  String maratialStatus = "";
  String type = "";
  String image = "";

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

  // Future<void> userList() async {
  //   isLoad = true;
  //   _preferences = await SharedPreferences.getInstance();
  //   _userListModel = await Services.GetUserMethod("${_preferences?.getString(ShadiApp.userId)}",CommonString.homesearch);
  //   if(_userListModel.status == 1){
  //     CommonString.homesearch=="";
  //     for(var i = 0; i < _userListModel.data!.length; i++){
  //       _userList = _userListModel.data ?? <UserDatum> [];
  //     }
  //   }
  //   isLoad = false;
  //   setState(() {
  //   });
  // }

  Future<void> userDetail() async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId).toString()}");
    if(_userDetailModel.status == 1){
      name = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      age = _userDetailModel.data![0].age.toString();
      place = _userDetailModel.data![0].city.toString();
      country = _userDetailModel.data![0].country.toString();
      height = _userDetailModel.data![0].height.toString();
      weight = _userDetailModel.data![0].weight.toString();
      image = _userDetailModel.data![0].image.toString();
      maratialStatus = _userDetailModel.data![0].maritalStatus.toString();
    }

   setState(() {
     clickLoad = false;
   });
  }
  Future<void> userViewPreference(String id) async {
    _viewPreferenceModel = await Services.ViewUserPreference(id);
    if(_viewPreferenceModel.status == 1){
      for (int i = 0; i < _viewPreferenceModel.data!.length; i++){
        intrest = _viewPreferenceModel.data ?? <PrefsDatum> [];
      }
    }
    setState(() {

    });
  }

  Future<void> like(String id, String type,String image,other_image,fullname) async {
    print(fullname);
    _preferences = await SharedPreferences.getInstance();
    _likeModel = await Services.LikeMethod(_preferences!.getString(ShadiApp.userId).toString(), id, type);
    if(_likeModel.status == 1){
      if (_likeModel.data![0].matched == true) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Match(image,other_image,_likeModel.data![0].id.toString(),fullname)
            )
        );

      }
      // Toaster.show(context, _likeModel.message.toString());
    }else{
      // Toaster.show(context, _likeModel.message.toString());
    }
  }

  @override
  void initState() {
    userDetail();
    CheckUserConnection();
    Getdata("");
    // userList();
    super.initState();
  }

  late Content content;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine = MatchEngine();

  bool isshowhome=false;
  void Getdata(String my_id) async{
    // String jsonStu = jsonEncode(datastring);
    // var data = jsonDecode(jsonStu);
    // content = Content.fromJson(data);
    setState(() {
      isshowhome=false;
    });
    _preferences = await SharedPreferences.getInstance();
    _userListModel = await Services.GetUserMethod("${_preferences?.getString(ShadiApp.userId)}",CommonString.homesearch,my_id);
    if(_userListModel.status==1) {
      CommonString.homesearch=="";
      if (_userListModel.data!.isNotEmpty) {
        for (int i = 0; i < _userListModel.data!.length; i++) {
          _userList = _userListModel.data ?? <UserDatum>[];
          _swipeItems.add(
              SwipeItem(
                  content: _userList.length,
                  likeAction: () {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Liked"),
                    //   duration: Duration(milliseconds: 500),
                    // ));
                    // print("objectLike");
                    type = "like";
                  },
                  nopeAction: () {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Nope"),
                    //   duration: Duration(milliseconds: 500),
                    // ));
                    type = "disLike";
                  },
                  superlikeAction: () {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   content: Text("Superliked"),
                    //   duration: Duration(milliseconds: 500),
                    // ));
                    type = "superLike";
                  },
                  onSlideUpdate: (SlideRegion? region) async {
                    // Toaster.show(context, "Region $region");
                  }));
        }
      }
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    isshowhome=true;
    if(mounted) {
      setState(() {
        print("works");
      });
    }
  }


  void showProfile(SwipeItem item, String image, String id){
    showBottomSheet(
      context: context,
      backgroundColor: CommonColors.themeblack,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return  ShowBottomSheet(image, id);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CommonColors.themeblack,
      body: Container(
          child: isLoad ? Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 3.0,
            ),
          ):Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/no_match_icon.png",),
                        SizedBox(height: 20,),
                        Text("No more profile available", style: TextStyle(fontSize: 16, fontFamily: 'dubai', color: CommonColors.buttonorg, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    )
                ),
                if(isshowhome) Container(
                  height: MediaQuery.of(context).size.height - 60,
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      UserDatum datum =  _userList[index];
                      return  Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            color:Colors.grey,
                            height:MediaQuery.of(context).size.height-60,
                            width: MediaQuery.of(context).size.width,
                            child:FadeInImage.assetNetwork(
                                placeholder: 'assets/home_placeholder.jpeg',
                                image:"${_userList[index].image}",
                              fit: BoxFit.cover,
                            )
                            // Image.network("${_swipeItems[index].content.image}",fit: BoxFit.cover),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/3,
                            width: MediaQuery.of(context).size.width,
                            padding:const EdgeInsets.only(left: 50,right: 30),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            color: CommonColors.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_back.png",color: Colors.black,height: 21,width: 21,)
                                              ),
                                              SizedBox.expand(
                                                child: Material(
                                                  type: MaterialType.transparency,
                                                  child: InkWell(onTap: () {
                                                    Getdata("${_preferences?.getString(ShadiApp.userId)}");
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
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap:(){
                                          _matchEngine.currentItem?.nope();
                                          like(_userList![index].id.toString(), "disLike",image,_userList![index].image,"${_userList[index].firstName![0].toUpperCase() + _userList[index].firstName!.substring(1)} ${_userList[index].lastName![0].toUpperCase() + _userList[index].lastName!.substring(1)}");
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            color: CommonColors.red,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_close.png",color: Colors.white,height: 21,width: 21)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap:(){
                                          _matchEngine!.currentItem?.superLike();
                                          like(_userList![index].id.toString(), "superLike",image,_userList![index].image,"${_userList[index].firstName![0].toUpperCase() + _userList[index].firstName!.substring(1)} ${_userList[index].lastName![0].toUpperCase() + _userList[index].lastName!.substring(1)}");
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            color: CommonColors.blue,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_star.png",color: Colors.white,height: 27,width: 27)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap:(){
                                          print("like");
                                          _matchEngine!.currentItem?.like();
                                          like(_userList![index].id.toString(), "like",image,_userList![index].image,"${_userList[index].firstName![0].toUpperCase() + _userList[index].firstName!.substring(1)} ${_userList[index].lastName![0].toUpperCase() + _userList[index].lastName!.substring(1)}");
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          margin: const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            color: CommonColors.green,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_like.png",color: Colors.white,height: 29,width: 29)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Spacer(),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      // new SizedBox(width: 40,),
                                      Expanded(
                                          child: Container(
                                            child: Column(
                                              children: [
                                                SizedBox(height: 15,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                           if(_userList[index].firstName.toString()!="null" && _userList[index].firstName.toString()!="")
                                                             Text(
                                                              "${_userList[index].firstName![0].toUpperCase() + _userList[index].firstName!.substring(1)}",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w900,
                                                                // height: 1.4
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                           if(_userList[index].lastName.toString()!="null" && _userList[index].lastName.toString()!="")
                                                             Text(
                                                              " ${_userList[index].lastName![0].toUpperCase() + _userList[index].lastName!.substring(1)}",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w900,
                                                                // height: 1.4
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                           if(_userList[index].age.toString()!="null" || _userList[index].age.toString()!="")
                                                             Text(
                                                               "  ${_userList[index].age}",
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w900,
                                                                // height: 1.4
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                            if(_userList[index].city.toString()!="null" && _userList[index].city.toString()!="") Text(
                                                             "${_userList[index].city} | ",
                                                              style: TextStyle(
                                                                color: CommonColors.lightblue,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                              maxLines: 1,
                                                              textAlign: TextAlign.left,
                                                            ),
                                                            if(_userList[index].state.toString()!="null" && _userList[index].state.toString()!="") Text(
                                                              "${_userList[index].state} | ",
                                                              style: TextStyle(
                                                                color: CommonColors.lightblue,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                              textAlign: TextAlign.left,
                                                            ),
                                                            if(_userList[index].country.toString()!="null" && _userList[index].country.toString()!="") Flexible(
                                                              child: Text(
                                                                "${_userList[index].country}",
                                                                style: TextStyle(
                                                                  color: CommonColors.lightblue,
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.w800,
                                                                ),
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                                textAlign: TextAlign.left,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Row(
                                                          children: [
                                                           if(_userList[index].height.toString()!="null" && _userList[index].height.toString()!="") Text(
                                                              "${_userList[index].height?.replaceAll(".", "`") } | ",
                                                                  // "${_userList[index].weight}kg | "
                                                                  // "${_userList[index].religion} |"
                                                                  // "${_userList[index].maritalStatus}",
                                                              style: TextStyle(
                                                                color: CommonColors.white,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                            if(_userList[index].weight.toString()!="null" && _userList[index].weight.toString()!="") Text(
                                                              // "${_userList[index].height?.replaceAll(".", "`") } | "
                                                                  "${_userList[index].weight}kg | "
                                                                  // "${_userList[index].religion} |"
                                                                  // "${_userList[index].maritalStatus}"
                                                              ,
                                                              style: TextStyle(
                                                                color: CommonColors.white,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                            if(_userList[index].religion.toString()!="null" && _userList[index].religion.toString()!="") Text(
                                                              // "${_userList[index].height?.replaceAll(".", "`") } | "
                                                                  // "${_userList[index].weight}kg | "
                                                                  "${_userList[index].religion} |"
                                                                  // "${_userList[index].maritalStatus}"
                                                              ,
                                                              style: TextStyle(
                                                                color: CommonColors.white,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                            if(_userList[index].maritalStatus.toString()!="null" && _userList[index].maritalStatus.toString()!="") Text(
                                                              // "${_userList[index].height?.replaceAll(".", "`") } | "
                                                                  // "${_userList[index].weight}kg | "
                                                                  // "${_userList[index].religion} |"
                                                                  "${_userList[index].maritalStatus}"
                                                              ,
                                                              style: TextStyle(
                                                                color: CommonColors.white,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w800,
                                                              ),
                                                              textAlign: TextAlign.left,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10,),
                                              ],
                                            ),
                                          )
                                      ),
                                      SizedBox(width: 20,),
                                      InkWell(
                                        onTap:(){
                                          SwipeItem item = _swipeItems[index];
                                          showProfile(item, _userList![index].image.toString(),_userList![index].id.toString());
                                          // userDetail();
                                          // userViewPreference(_userList![index].id.toString());
                                          },
                                        child: Container(
                                          height: 29,
                                          width: 29,
                                          margin: const EdgeInsets.symmetric(horizontal: 0),
                                          decoration: BoxDecoration(
                                            color: CommonColors.white,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_backup.png",color: Colors.black,height: 21,width: 21,)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // new SizedBox(width: 20,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${_userList![index].firstName}, index: $index");
                      like(_userList![index-1].id.toString(), type,image,_userList![index-1].image,"${_userList[index-1].firstName![0].toUpperCase() + _userList[index-1].firstName!.substring(1)} ${_userList[index-1].lastName![0].toUpperCase() + _userList[index-1].lastName!.substring(1)}");
                    },
                    leftSwipeAllowed: true,
                    rightSwipeAllowed: true,
                    upSwipeAllowed: true,
                    fillSpace: true,
                    likeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.green)
                      // ),
                      child: Text('Like',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    nopeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.red)
                      // ),
                      child: Text('Nope',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                    ),
                    superLikeTag: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.orange)
                      // ),
                      child: Text('Super Like',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                    ),
                    onStackFinished: () {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Stack Finished"),
                      //   duration: Duration(milliseconds: 500),
                      // ));
                    },
                  ),
                )
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     height: MediaQuery.of(context).size.height/5.5,
                //     width: MediaQuery.of(context).size.width,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         new Container(
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               InkWell(
                //                 onTap:(){
                //                   },
                //                 child: Container(
                //                   height: 50,
                //                   width: 50,
                //                   margin: const EdgeInsets.symmetric(horizontal: 20),
                //                   decoration: BoxDecoration(
                //                     color: CommonColors.white,
                //                     borderRadius: const BorderRadius.all(Radius.circular(25)),
                //                   ),
                //                   child: Stack(
                //                     children: <Widget>[
                //                       Center(
                //                           child: Image.asset("assets/home_back.png",color: Colors.black,height: 21,width: 21,)
                //                       ),
                //                       SizedBox.expand(
                //                         child: Material(
                //                           type: MaterialType.transparency,
                //                           child: InkWell(onTap: () {
                //                           },splashColor: Colors.blue.withOpacity(0.2),
                //                             customBorder: RoundedRectangleBorder(
                //                               borderRadius: BorderRadius.circular(25),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               InkWell(
                //                 onTap:(){
                //                   _matchEngine!.currentItem?.nope();
                //                 },
                //                 child: Container(
                //                   height: 50,
                //                   width: 50,
                //                   margin: const EdgeInsets.symmetric(horizontal: 20),
                //                   decoration: BoxDecoration(
                //                     color: CommonColors.red,
                //                     borderRadius: const BorderRadius.all(Radius.circular(25)),
                //                   ),
                //                   child: Stack(
                //                     children: <Widget>[
                //                       Center(
                //                           child: Image.asset("assets/home_close.png",color: Colors.white,height: 21,width: 21)
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               InkWell(
                //                 onTap:(){
                //                   _matchEngine!.currentItem?.superLike();
                //
                //                 },
                //                 child: Container(
                //                   height: 50,
                //                   width: 50,
                //                   margin: const EdgeInsets.symmetric(horizontal: 20),
                //                   decoration: BoxDecoration(
                //                     color: CommonColors.blue,
                //                     borderRadius: const BorderRadius.all(Radius.circular(25)),
                //                   ),
                //                   child: Stack(
                //                     children: <Widget>[
                //                       Center(
                //                           child: Image.asset("assets/home_star.png",color: Colors.white,height: 21,width: 21)
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //
                //               InkWell(
                //                 onTap:(){
                //                   print("like");
                //                   _matchEngine!.currentItem?.like();
                //                 },
                //                 child: Container(
                //                   height: 50,
                //                   width: 50,
                //                   margin: const EdgeInsets.symmetric(horizontal: 20),
                //                   decoration: BoxDecoration(
                //                     color: CommonColors.green,
                //                     borderRadius: const BorderRadius.all(Radius.circular(25)),
                //                   ),
                //                   child: Stack(
                //                     children: <Widget>[
                //                       Center(
                //                           child: Image.asset("assets/home_like.png",color: Colors.white,height: 21,width: 21)
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //
                //
                //
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child:
                //   new Container(
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Container(
                //           height: 50,
                //           width: 50,
                //           margin: const EdgeInsets.only(right: 40),
                //           decoration: BoxDecoration(
                //             color: CommonColors.white,
                //             borderRadius: const BorderRadius.all(Radius.circular(25)),
                //           ),
                //           child: Stack(
                //             children: <Widget>[
                //               Center(
                //                   child: Image.asset("assets/home_back.png",color: Colors.black,height: 21,width: 21,)
                //               ),
                //               SizedBox.expand(
                //                 child: Material(
                //                   type: MaterialType.transparency,
                //                   child: InkWell(onTap: () {
                //                   },splashColor: Colors.blue.withOpacity(0.2),
                //                     customBorder: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(25),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           height: 50,
                //           width: 50,
                //           margin: const EdgeInsets.only(right: 40),
                //           decoration: BoxDecoration(
                //             color: CommonColors.red,
                //             borderRadius: const BorderRadius.all(Radius.circular(25)),
                //           ),
                //           child: Stack(
                //             children: <Widget>[
                //               Center(
                //                   child: Image.asset("assets/home_close.png",color: Colors.white,height: 21,width: 21)
                //               ),
                //               SizedBox.expand(
                //                 child: Material(
                //                   type: MaterialType.transparency,
                //                   child: InkWell(onTap: () {
                //                     _matchEngine!.currentItem?.nope();
                //                   },splashColor: Colors.blue.withOpacity(0.2),
                //                     customBorder: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(25),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           height: 50,
                //           width: 50,
                //           margin: const EdgeInsets.only(right: 40),
                //           decoration: BoxDecoration(
                //             color: CommonColors.blue,
                //             borderRadius: const BorderRadius.all(Radius.circular(25)),
                //           ),
                //           child: Stack(
                //             children: <Widget>[
                //               Center(
                //                   child: Image.asset("assets/home_star.png",color: Colors.white,height: 21,width: 21)
                //               ),
                //               SizedBox.expand(
                //                 child: Material(
                //                   type: MaterialType.transparency,
                //                   child: InkWell(onTap: () {
                //                     _matchEngine!.currentItem?.superLike();
                //                   },splashColor: Colors.blue.withOpacity(0.2),
                //                     customBorder: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(25),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           height: 50,
                //           width: 50,
                //           // margin: const EdgeInsets.symmetric(horizontal: 20),
                //           decoration: BoxDecoration(
                //             color: CommonColors.green,
                //             borderRadius: const BorderRadius.all(Radius.circular(25)),
                //           ),
                //           child: Stack(
                //             children: <Widget>[
                //               Center(
                //                   child: Image.asset("assets/home_like.png",color: Colors.white,height: 21,width: 21)
                //               ),
                //               SizedBox.expand(
                //                 child: Material(
                //                   type: MaterialType.transparency,
                //                   child: InkWell(onTap: () {
                //                     _matchEngine!.currentItem?.like();
                //                   },splashColor: Colors.blue.withOpacity(0.2),
                //                     customBorder: RoundedRectangleBorder(
                //                       borderRadius: BorderRadius.circular(25),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ]))
    );
  }
}

class ShowBottomSheet extends StatefulWidget {

  String image = "";
  String id = "";
  ShowBottomSheet(this.image, this.id);

  @override
  State<StatefulWidget> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<ShowBottomSheet> {

  SharedPreferences? _preferences;
  late UserViewPreferenceModel _viewPreferenceModel;
  late UserDetailModel _userDetailModel = UserDetailModel();
  List<String> intrest = [];
  bool clickLoad = false;
  bool isLoad = false;

  String name = "";
  String lastName = "";
  String age = "";
  String place = "";
  String country = "";
  String state = "";
  String height = "";
  String weight = "";
  String religion = "";
  String marriagePlan = "";
  String plan_user = "";
  String aboutme = "";
  String maratialStatus = "";

  String zodiac_sign = "";
  String education_level = "";
  String covid_vaccine = "";
  String petss = "";
  String dietary_preference = "";
  String sleeping_habits = "";
  String social_media = "";
  String workouts = "";
  String smokings = "";
  String healths = "";
  String drinkings = "";
  int isVerified=0;
  String personality_type = "";

  Future<void> userDetail() async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    // _userDetailModel = await Services.UserDetailMethod("641997803e3c4036ee2e1f78");
    _userDetailModel = await Services.OtherUserDetailMethod(widget.id);
    if(_userDetailModel.status == 1){
      name = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      profilename= "${name} ${lastName}";
      age = _userDetailModel.data![0].age.toString();
      place = _userDetailModel.data![0].city.toString();
      state = _userDetailModel.data![0].state.toString();
      country = _userDetailModel.data![0].country.toString();
      religion = _userDetailModel.data![0].religion.toString();
      height = _userDetailModel.data![0].height.toString();
      weight = _userDetailModel.data![0].weight.toString();
      maratialStatus = _userDetailModel.data![0].maritalStatus.toString();
      aboutme = _userDetailModel.data![0].about.toString();
      marriagePlan = _userDetailModel.data![0].marriagePlan.toString();
      zodiac_sign = _userDetailModel.data![0].zodiacSign.toString();
      covid_vaccine = _userDetailModel.data![0].covidVaccine.toString();
      petss = _userDetailModel.data![0].pets.toString();
      dietary_preference = _userDetailModel.data![0].dietaryPreference.toString();
      education_level = _userDetailModel.data![0].educationLevel.toString();
      sleeping_habits = _userDetailModel.data![0].sleepingHabits.toString();
      social_media = _userDetailModel.data![0].socialMedia.toString();
      workouts = _userDetailModel.data![0].workout.toString();
      healths = _userDetailModel.data![0].health.toString();
      smokings = _userDetailModel.data![0].smoking.toString();
      drinkings = _userDetailModel.data![0].drinking.toString();
      personality_type = _userDetailModel.data![0].personalityType.toString();
      plan_user = _userDetailModel.data![0].plan.toString();
      intrest = _userDetailModel.data![0].preference ?? [];
      isVerified = _userDetailModel.data![0].isVerified ?? 0;
    }

    setState(() {
      clickLoad = false;
    });
  }

  // Future<void> userViewPreference() async {
  //   _viewPreferenceModel = await Services.ViewUserPreference(widget.id);
  //   if(_viewPreferenceModel.status == 1){
  //     for (int i = 0; i < _viewPreferenceModel.data!.length; i++){
  //       intrest = _viewPreferenceModel.data ?? <PrefsDatum> [];
  //     }
  //   }
  //   setState(() {
  //
  //   });
  // }

  @override
  void initState() {
    userDetail();
    // userViewPreference();
    super.initState();
  }

  // String profileimage = "";
  String profilename = "";
  void shareProfile(String profileName, String profileImageURL,String user_id) {
    Share.share('Check out $profileName\'s profile: $profileImageURL\n Link: http://52.63.253.231:4000/api/v1/user/${widget.id}');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState){
        double rating = 3.5;
        List<String> about = [
          'Loving',
          'Caring',
          'Humoristic',
          'Spontanious',
        ];
        return  clickLoad == true ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3.0,
          ),
        ):Container(
          height: MediaQuery.of(context).size.height-60,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).padding.top+60,
                        ),
                        Stack(
                          children: [
                            Container(
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network("${widget.image}",fit: BoxFit.cover,height: 400,width: MediaQuery.of(context).size.width,),
                                )
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              // margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                 if(name!="null") Text(
                                     "${name[0].toUpperCase()+name.substring(1)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(lastName!="null") Text(
                                     " ${lastName[0].toUpperCase()+lastName.substring(1)}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(age!="null") Text(
                                     " ${age}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15,),
                           if(isVerified==2) SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset("assets/blue_tick.png",height: 25,width: 25,),
                            )
                          ],
                        ),
                        SizedBox(height: 11,),
                        Container(
                          alignment: Alignment.topLeft,
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 if(place!="null") Text(
                                    "${place},",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(state!="null") Text(
                                    "${state},",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(country!="null") Text(
                                    "${country} ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 if(height!="null") Text(
                                        " ${height.replaceAll(".", "`")},",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(weight!="null") Text(
                                        " ${weight}kg,",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(religion!="null") Text(
                                   " ${religion},",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                 if(maratialStatus!="null") Text(
                                        " ${maratialStatus}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 14,),
                        Row(
                          children: [
                            Container(
                              height:26,
                              decoration: BoxDecoration(
                                color:CommonColors.yellow,
                                border: Border.all(
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(32.0) //                 <--- border radius here
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                              alignment: Alignment.center,
                              child: Text(plan_user!="null" ? "$plan_user":"Basic",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                child: StarRating(
                                  color: CommonColors.yellow,
                                  rating: rating,
                                  size:26,
                                  onRatingChanged: (rating) => setState(() => rating = rating),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 11,),

                        if(marriagePlan!="null")  Row(
                          children: [
                            Container(
                              height:23,
                              // width: 120,
                              decoration: BoxDecoration(
                                color:CommonColors.buttonorg,
                                border: Border.all(
                                    width: 1.0
                                ),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(32.0) //                 <--- border radius here
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                              alignment: Alignment.centerLeft,
                              child: Text("$marriagePlan",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Container(height: 1,width: double.infinity,color: Colors.white,),
                        if(aboutme!="null" && aboutme!="") SizedBox(height: 40,),
                        if(aboutme!="null" && aboutme!="") Container(
                          alignment: Alignment.centerLeft,
                          child: Text("ABOUT ME",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                        if(aboutme!="null" && aboutme!="") SizedBox(height: 10,),
                        if(aboutme!="null" && aboutme!="") Container(
                          alignment: Alignment.centerLeft,
                          child: Text("$aboutme",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),textAlign: TextAlign.start,),
                        ),
                        // new SizedBox(height: 10,),
                        // Container(
                        //   alignment: Alignment.centerLeft,
                        //   child: Wrap(
                        //     children: [
                        //       ...List.generate(
                        //         about.length,
                        //             (index) => GestureDetector(
                        //           child: Container(
                        //               margin: const EdgeInsets.only(right: 5,top:5),
                        //               decoration: BoxDecoration(
                        //                 color: CommonColors.buttonorg,
                        //                 borderRadius: BorderRadius.circular(65),
                        //               ),
                        //               padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                        //               child: Row(
                        //                 mainAxisSize: MainAxisSize.min,
                        //                 children: [
                        //                   Text("${about[index]}",style: new TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white),),
                        //                 ],
                        //               )
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        if(intrest.isNotEmpty)  SizedBox(height: 40,),
                        if(intrest.isNotEmpty)  Container(
                          alignment: Alignment.centerLeft,
                          child: Text("My Interests",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                        if(intrest.isNotEmpty) SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                intrest.length,
                                    (index) => GestureDetector(
                                  child: Container(
                                      margin: const EdgeInsets.only(right: 5,top:5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        // color: CommonColors.buttonorg,
                                        borderRadius: BorderRadius.circular(65),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${intrest[index]}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                                        ],
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text("General Info",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),

                  CustomlayoutView(icon: 'assets/zodiac_icon.png',tittle: 'Zodiac',status: zodiac_sign!="null" ?'$zodiac_sign':"",),
                  CustomlayoutView(icon: 'assets/education_bottom.png',tittle: 'Education',status: education_level!="null" ?'$education_level':"",),
                  CustomlayoutView(icon: 'assets/covid_bottom.png',tittle: 'COVID vaccine',status: covid_vaccine!="null" ?'$covid_vaccine':"",),
                  CustomlayoutView(icon: 'assets/health_bottom.png',tittle: 'Health',status: healths!="null" ?'$healths':"",),
                  CustomlayoutView(icon: 'assets/persional_bottom.png',tittle: 'Personality type',status: personality_type!="null" ?"$personality_type":"",),

                  SizedBox(height: 40,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    child: Text("Lifestyle",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  CustomlayoutView(icon: 'assets/pet_icon.png',tittle: 'Pets',status: petss!="null" ?'$petss':"",),
                  CustomlayoutView(icon: 'assets/drink_bottom.png',tittle: 'Drinking',status: drinkings!="null" ?"$drinkings":"",),
                  CustomlayoutView(icon: 'assets/smoke_bottom.png',tittle: 'Smoking',status: smokings!="null" ?'$smokings':"",),
                  CustomlayoutView(icon: 'assets/workout_bottom.png',tittle: 'Workout',status: workouts!="null" ?'$workouts':"",),
                  CustomlayoutView(icon: 'assets/dientary_bottom.png',tittle: 'Dietary preference',status: dietary_preference!="null" ?'$dietary_preference':"",),
                  CustomlayoutView(icon: 'assets/social_bottom.png',tittle: 'Social media',status: social_media!="null" ?'$social_media':"",),
                  CustomlayoutView(icon: 'assets/sleep_bottom.png',tittle: 'Sleeping habits',status: social_media!="null" ?'$sleeping_habits':"",),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap:(){
                      shareProfile(profilename, "${widget.image}", "${_preferences?.getString(ShadiApp.userId)}");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.center,
                      child: Text("SHARE THIS PROFILE ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                    ),
                  ),
                  SizedBox(height: 60,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
