import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/Models/top_picks_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopPicks extends StatefulWidget {
  @override
  State<TopPicks> createState() => _TopPicks();

}

class _TopPicks extends State<TopPicks> {

  late SharedPreferences _preferences;
  late TopPicksModel _topPicksModel;
  List<Datum> _list = [];
  bool isLoad = false;

  Future<void> topPicks() async {
    setState(() {
      isLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _topPicksModel = await Services.TopPicksList(_preferences.getString(ShadiApp.userId).toString());
    if(_topPicksModel.status == 1){
      for(var i = 0; i < _topPicksModel.data!.length; i++){
        _list = _topPicksModel.data ?? <Datum> [];
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
   topPicks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.width / 2)+20;
    final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: isLoad ? Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3.0,
        ),
      ):Container(
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 15.0,
              childAspectRatio: (itemWidth / itemHeight),
            ),
            itemCount: _list.length,
            itemBuilder: (context, index){
              Datum data = _list[index];
              return Container(
                child: Container(
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
                              Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                // height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff66DFD7D7),
                                      Color(0xff00D9D9D9),
                                    ],
                                    begin: Alignment.center,
                                    end: Alignment.bottomRight,)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text("${data.name}, ${data.age}",
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,
                                              fontSize: 14),),
                                      ),
                                      Spacer(),
                                      Container(
                                        height: 28,
                                        margin: const EdgeInsets.symmetric(vertical: 6),
                                        width: 28,
                                        child: Image.asset("assets/white_bg_star.png",height: 28,width: 28),
                                      )
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
    );
  }

}