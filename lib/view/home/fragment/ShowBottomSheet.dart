
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/StarRating.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_view_preference_model.dart';
import 'package:shadiapp/Models/view_image_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayoutview.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isonline=false;

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
      isonline = _userDetailModel.data![0].isOnline ?? false;
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
  int pageIndex=0;
  List<ImageDatum> _list = [];
  ViewImageModel? _viewImageModel;
  Future<void> viewImage() async {
    isLoad = true;
    _viewImageModel = await Services.ImageView("${widget.id}");
    if(_viewImageModel!=null) {
      if (_viewImageModel?.status == 1) {
        for (var i = 0; i < _viewImageModel!.data!.length; i++) {
          _list = _viewImageModel?.data ?? <ImageDatum>[];
        }
      } else {
        _list = [];
      }
    }
    isLoad = false;
    setState(() {});
  }



  @override
  void initState() {
    viewImage();
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
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: 400,
                                        viewportFraction: 1,
                                        initialPage: 0,
                                        enableInfiniteScroll: false,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index,reason){
                                          setState(() {
                                            pageIndex=index;
                                          });
                                        },
                                      ),
                                      items: _list.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Image.network("${i.image}",fit: BoxFit.cover,height: 400,width: MediaQuery.of(context).size.width,);
                                          },
                                        );
                                      }).toList(),
                                    )


                                  // Image.network("${widget.image}",fit: BoxFit.cover,height: 400,width: MediaQuery.of(context).size.width,),
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
                            ),
                            if(_list.isNotEmpty) Positioned(
                              right:0,
                              left:0,
                              bottom:10,
                              top:0,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CarouselIndicator(
                                  index: pageIndex, // Use the same controller as the CarouselSlider
                                  count: _list.length, // Number of items in the slider
                                  color: Colors.grey, // Color of inactive dots
                                  activeColor: CommonColors.buttonorg, // Color of active dot
                                  height: 8.0, // Height of the dots
                                ),
                              ),
                            ),
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
                            ),

                            // if(isonline) StreamBuilder(
                            //   stream: FirebaseDatabase.instance
                            //       .reference()
                            //       .child('users/${widget.id}/status')
                            //       .onValue,
                            //   builder: (context, snapshot) {
                            //     if (snapshot.hasData) {
                            //       final status = snapshot.data?.snapshot.value;
                            //       final isOnline = status == 'online';
                            //       return CircleAvatar(
                            //         backgroundColor: isOnline ? Colors.green : Colors.grey,
                            //         radius: 5.0,
                            //       );
                            //     }else{
                            //       return CircleAvatar(
                            //         backgroundColor: Colors.grey,
                            //         radius: 5.0,
                            //       );
                            //     }
                            //     // Loading indicator
                            //   },
                            // ),

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