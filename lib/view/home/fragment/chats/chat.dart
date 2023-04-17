import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/view/home/fragment/chats/ChatRoom.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      endDrawer: Drawer(
        width: 180,
        // backgroundColor: CommonColors.matchDrawer,
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
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18.5,vertical: 0),
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Image.asset(
                      'assets/settings.png',
                      width: 20,
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Likes you 45",
                  style: TextStyle(color: CommonColors.buttonorg),
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0, right: 20.0, bottom: 10.0),
              height: 100,
              child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return Container(
                      child: Container(
                        width: 75,
                        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
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
                                      image: NetworkImage(images[index]),
                                  fit: BoxFit.fill)
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
                                                    style: TextStyle(color: Colors.white),),
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
                child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
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
                                        builder: (context) => ChatRoom(images[index])
                                    )
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(images[index]),
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
                                              margin: EdgeInsets.only(left: 10.0),
                                              child: Text("Jimmy",
                                                style: TextStyle(
                                                  color: Colors.white, fontSize: 16,
                                                    fontWeight: FontWeight.w500, fontStyle: FontStyle.normal
                                                ),
                                              )
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 10.0),
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
                                    Container(
                                      alignment: Alignment.topCenter,
                                        margin: EdgeInsets.only(left: 10.0, right: 20.0, bottom: 10.0),
                                        child: Text("1h",
                                          style: TextStyle(
                                              color: Colors.white30, fontSize: 15
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
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

}