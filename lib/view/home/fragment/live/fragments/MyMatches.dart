import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/Models/my_matches_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyMatches extends StatefulWidget {
  @override
  State<MyMatches> createState() => _MyMatchesState();

}

class _MyMatchesState extends State<MyMatches> {

  late SharedPreferences _preferences;
  late MyMatchesModel _matchesModel;
  List<Datum> _list = [];
  bool isLoad = false;

  Future<void> match() async {
    setState(() {
      isLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _matchesModel = await Services.MyMatchesList(_preferences.getString(ShadiApp.userId).toString());
    if(_matchesModel.status == 1){
      for(var i = 0; i < _matchesModel.data!.length; i++){
        _list = _matchesModel.data ?? <Datum> [];
      }
    }
    setState(() {
      isLoad = false;
    });
  }

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
    match();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: isLoad ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3.0,
        ),
      ):_matchesModel.data!.isEmpty  ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/no_live_icon.png",),
              SizedBox(height: 20,),
              Text("No Live", style: TextStyle(fontSize: 16, fontFamily: 'dubai', color: CommonColors.buttonorg, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            ],
          )
      ):Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 10.0),
                    itemCount: _list.length,
                    itemBuilder: (context, index){
                      Datum data = _list[index];
                      return Container(
                        child: InkWell(
                          onTap: (){
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15.0)),
                              color: CommonColors.bottomgrey,
                            ),
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(data.image.toString()),
                                          fit: BoxFit.fill)
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                                          child:
                                          Container(
                                            child: Text("${data.firstName}, ${data.age}",
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                                          ),
                                        ),
                                      ]
                                  )
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}