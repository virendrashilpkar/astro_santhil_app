import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/StarRating.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/view/home/fragment/homesearch/Content.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayout.dart';
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
    Getdata();

    super.initState();
  }


  var datastring = {
    "data": [
      {
        "image": "https://w0.peakpx.com/wallpaper/564/224/HD-wallpaper-beautiful-girl-bengali-eyes-holi-indian.jpg",
        "name": "Annamika Sinha",
        "age": "25",
        "place": "Los Angeles|USA|Panjabi",
        "height": "5'6",
        "weight": "56kg",
        "region": "Hindu",
        "status": "Never Married"
      },
      {
        "image": "https://w0.peakpx.com/wallpaper/396/511/HD-wallpaper-bong-angel-bengali.jpg",
        "name": "Shalu Singh",
        "age": "22",
        "place": "Indore|Bhopal|Gujrati",
        "height": "5'2",
        "weight": "20kg",
        "region": "Hindu",
        "status": "Never Married"
      },
      {
        "image": "https://w0.peakpx.com/wallpaper/798/474/HD-wallpaper-beauty-123-beautiful-ivana-saree.jpg",
        "name": "Ivana Sinha",
        "age": "25",
        "place": "Los Angeles|USA|Panjabi",
        "height": "5'6",
        "weight": "56kg",
        "region": "Hindu",
        "status": "Never Married"
      },
      {
        "image": "https://w0.peakpx.com/wallpaper/366/237/HD-wallpaper-vaishnavi-beautiful-saree.jpg",
        "name": "Priya Singh",
        "age": "22",
        "place": "Indore|Bhopal|Gujrati",
        "height": "5'2",
        "weight": "20kg",
        "region": "Hindu",
        "status": "Never Married"
      },
      {
        "image": "https://w0.peakpx.com/wallpaper/233/819/HD-wallpaper-vaishnavi-shanu-short-film-software-developer.jpg",
        "name": "Vaishnavi Shanu",
        "age": "25",
        "place": "Los Angeles|USA|Panjabi",
        "height": "5'6",
        "weight": "56kg",
        "region": "Hindu",
        "status": "Never Married"
      },
      {
        "image": "https://w0.peakpx.com/wallpaper/344/1000/HD-wallpaper-ashika-ranganath-saree-lover-model.jpg",
        "name": "Ashika Ranganath",
        "age": "22",
        "place": "Indore|Bhopal|Gujrati",
        "height": "5'2",
        "weight": "20kg",
        "region": "Hindu",
        "status": "Never Married"
      },
  {
  "image": "https://w0.peakpx.com/wallpaper/280/777/HD-wallpaper-anju-kurien-mallu-actress-saree-lover.jpg",
  "name": "Jasmine Lee",
  "age": "26",
  "place": "Seoul|South Korea|Korean",
  "height": "5'5",
  "weight": "50kg",
  "religion": "Buddhist",
  "status": "Never Married"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/373/1013/HD-wallpaper-anju-32-actress-girl-mallu-anju-kurian.jpg",
  "name": "Emily Smith",
  "age": "35",
  "place": "Sydney|Australia|Caucasian",
  "height": "5'8",
  "weight": "60kg",
  "religion": "Christian",
  "status": "Divorced"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/306/75/HD-wallpaper-anju-kurian-babu-suren.jpg",
  "name": "Maria Rodriguez",
  "age": "29",
  "place": "Buenos Aires|Argentina|Latina",
  "height": "5'6",
  "weight": "55kg",
  "religion": "Catholic",
  "status": "Single"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/504/652/HD-wallpaper-anju-kurian-anju-kurian-mallu.jpg",
  "name": "Lucy Garcia",
  "age": "22",
  "place": "Madrid|Spain|Hispanic",
  "height": "5'4",
  "weight": "48kg",
  "religion": "Agnostic",
  "status": "Never Married"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/290/185/HD-wallpaper-anju-kurian-flash-graphy-lip.jpg",
  "name": "Sarah Johnson",
  "age": "31",
  "place": "New York|USA|African American",
  "height": "5'9",
  "weight": "65kg",
  "religion": "Protestant",
  "status": "Divorced"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/320/566/HD-wallpaper-jisoo-jisoo-blackpink.jpg",
  "name": "Hannah Nguyen",
  "age": "27",
  "place": "Hanoi|Vietnam|Asian",
  "height": "5'6",
  "weight": "52kg",
  "religion": "Buddhist",
  "status": "Single"
  },
  {
  "image": "https://w0.peakpx.com/wallpaper/862/303/HD-wallpaper-jisoo-blackpink-blackpink-jisoo-k-pop.jpg",
  "name": "Emma Williams",
  "age": "24",
  "place": "London|UK|Caucasian",
  "height": "5'7",
  "weight": "57kg",
  "religion": "Atheist",
  "status": "Never Married"
  },
      {
        "image": "https://w0.peakpx.com/wallpaper/509/744/HD-wallpaper-jisoo-blackpink-cute-k-pop-love-music.jpg",
        "name": "Grace Kim",
        "age": "32",
        "place": "Tokyo|Japan|Asian",
        "height": "5'4",
        "weight": "49kg",
        "religion": "Shinto",
        "status": "Divorced"
      }
  ]
  };
  late Content content;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  void Getdata(){
    String jsonStu = jsonEncode(datastring);
    var data = jsonDecode(jsonStu);
    content = Content.fromJson(data);

    for (int i = 0; i < content.data!.length; i++) {
      Datum getdata=content.data![i];
      _swipeItems.add(SwipeItem(
          content: getdata,
          likeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Liked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Nope"),
              duration: Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Superliked"),
              duration: Duration(milliseconds: 500),
            ));
          },
          onSlideUpdate: (SlideRegion? region) async {
            print("Region $region");
            // Toaster.show(context, "Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);

    setState(() {
      print("works");
    });
  }


  void showProfile(BuildContext context,SwipeItem item){

    showBottomSheet(
      context: context,
      backgroundColor: CommonColors.themeblack,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            double rating = 3.5;
            List<String> about = [
              'Loving',
              'Caring',
              'Humoristic',
              'Spontanious',
            ];
            List<String> intrest = [
              'Reading',
              'Reading',
              'Reading',
              'Reading',
            ];
            return Container(
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
                            Container(

                                child:  ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Image.network("${item.content.image}",fit: BoxFit.cover,height: 400,width: MediaQuery.of(context).size.width,),
                                )
                            ),
                            new SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "${item.content.name}  ${item.content.age}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                new SizedBox(width: 15,),
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Image.asset("assets/blue_tick.png",height: 25,width: 25,),
                                )
                              ],
                            ),
                            new SizedBox(height: 11,),
                            Container(
                              alignment: Alignment.topLeft,
                              // margin: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "${item.content.place}\n"
                                    "${item.content.height}|"
                                    "${item.content.weight}|"
                                    "${item.content.region}|"
                                    "${item.content.status}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),

                            new SizedBox(height: 14,),
                            Row(
                              children: [
                                Container(
                                  // height:23,
                                  decoration: BoxDecoration(
                                    color:CommonColors.yellow,
                                    border: Border.all(
                                        width: 1.0
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(32.0) //                 <--- border radius here
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 9,vertical: 6),
                                  alignment: Alignment.center,
                                  child: Text("GOLD",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: new StarRating(
                                      color: CommonColors.yellow,
                                      rating: rating,
                                      onRatingChanged: (rating) => setState(() => rating = rating),
                                    )
                                )
                              ],
                            ),
                            new SizedBox(height: 11,),

                            Row(
                              children: [
                                Container(
                                  // height:23,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                  alignment: Alignment.centerLeft,
                                  child: Text("Within 3 months",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                                ),
                              ],
                            ),
                            new SizedBox(height: 40,),
                            new Container(height: 1,width: double.infinity,color: Colors.white,),
                            new SizedBox(height: 40,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("ABOUT ME",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                            ),
                            new SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("I am a gentle lady who loves to have fun, i sleep early and loves to sing before i sleep which is quite unormal tough. I have a farm somewhere",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),textAlign: TextAlign.start,),
                            ),
                            new SizedBox(height: 10,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  ...List.generate(
                                    about.length,
                                        (index) => GestureDetector(
                                      child: Container(
                                          margin: const EdgeInsets.only(right: 5,top:5),
                                          decoration: BoxDecoration(
                                            color: CommonColors.buttonorg,
                                            borderRadius: BorderRadius.circular(65),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text("${about[index]}",style: new TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white),),
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new SizedBox(height: 40,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("My Interests",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                            ),
                            new SizedBox(height: 20,),
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
                                              Text("${intrest[index]}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                                            ],
                                          )
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            new SizedBox(height: 40,),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("General Info",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                            ),
                            new SizedBox(height: 20,),
                          ],
                        ),
                      ),

                      Customlayout(icon: 'assets/zodiac_icon.png',tittle: 'Zodiac',status: 'Libra',),
                      Customlayout(icon: 'assets/education_bottom.png',tittle: 'Education',status: 'Master degree',),
                      Customlayout(icon: 'assets/covid_bottom.png',tittle: 'COVID vaccine',status: 'Not added',),
                      Customlayout(icon: 'assets/health_bottom.png',tittle: 'Health',status: 'Not added',),
                      Customlayout(icon: 'assets/persional_bottom.png',tittle: 'Personality type',status: 'Add',),

                      new SizedBox(height: 40,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.centerLeft,
                        child: Text("Lifestyle",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                      ),
                      new SizedBox(height: 20,),
                      Customlayout(icon: 'assets/pet_icon.png',tittle: 'Pets',status: 'Dog',),
                      Customlayout(icon: 'assets/drink_bottom.png',tittle: 'Drinking',status: 'On special occasions',),
                      Customlayout(icon: 'assets/smoke_bottom.png',tittle: 'Smoking',status: 'Non-smoker',),
                      Customlayout(icon: 'assets/workout_bottom.png',tittle: 'Workout',status: 'Often',),
                      Customlayout(icon: 'assets/dientary_bottom.png',tittle: 'Dietary preference',status: 'Not added',),
                      Customlayout(icon: 'assets/social_bottom.png',tittle: 'Social media',status: 'Socially active',),
                      Customlayout(icon: 'assets/sleep_bottom.png',tittle: 'Sleeping habits',status: 'Early bird',),
                      new SizedBox(height: 40,),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.center,
                        child: Text("SHARE THIS PROFILE ",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                      ),
                      new SizedBox(height: 60,),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CommonColors.white,
      body: Container(
          child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Match not found",style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 60,
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return  Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            color:Colors.grey,
                            height:MediaQuery.of(context).size.height-60,
                            width: MediaQuery.of(context).size.width,
                            child:FadeInImage.assetNetwork(
                                placeholder: 'assets/home_placeholder.jpeg',
                                image:"${_swipeItems[index].content.image}",
                              fit: BoxFit.cover,
                            )
                            // Image.network("${_swipeItems[index].content.image}",fit: BoxFit.cover),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height/3,
                            width: MediaQuery.of(context).size.width,
                            padding:const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black54],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                new Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap:(){
                                          Navigator.of(context).pop();
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
                                                  child: Image.asset("assets/home_star.png",color: Colors.white,height: 21,width: 21)
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
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: CommonColors.green,
                                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                                          ),
                                          child: Stack(
                                            children: <Widget>[
                                              Center(
                                                  child: Image.asset("assets/home_like.png",color: Colors.white,height: 21,width: 21)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                new Container(
                                  child: Row(
                                    children: [
                                      // new SizedBox(width: 40,),
                                      new Expanded(
                                          child: Container(
                                            child: Column(
                                              children: [
                                                new SizedBox(height: 15,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Text(
                                                          "${_swipeItems[index].content.name}   ${_swipeItems[index].content.age}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                          textAlign: TextAlign.left,
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
                                                        child: Text(
                                                          "${_swipeItems[index].content.place}",
                                                          style: TextStyle(
                                                            color: CommonColors.lightblue,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                new SizedBox(height: 5,),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        alignment: Alignment.topLeft,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: Text(
                                                          "${_swipeItems[index].content.height}|"
                                                              "${_swipeItems[index].content.weight}|"
                                                              "${_swipeItems[index].content.region}|"
                                                              "${_swipeItems[index].content.status}",
                                                          style: TextStyle(
                                                            color: CommonColors.white,
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                new SizedBox(height: 10,),
                                              ],
                                            ),
                                          )
                                      ),
                                      new SizedBox(width: 20,),
                                      InkWell(
                                        onTap:(){
                                          SwipeItem item = _swipeItems[index];
                                          showProfile(context,item);
                                          },
                                        child: Container(
                                          height: 29,
                                          width: 29,
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    onStackFinished: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                    },
                    itemChanged: (SwipeItem item, int index) {
                      print("item: ${item.content.name}, index: $index");
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
                  ),
                ),
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
