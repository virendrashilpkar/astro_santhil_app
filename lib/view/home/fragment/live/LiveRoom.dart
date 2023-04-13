import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class LiveRoom extends StatefulWidget {
  String image = "";

  LiveRoom(this.image);
  @override
  State<LiveRoom> createState() => _LiveRoomState();

}

class _LiveRoomState extends State<LiveRoom> {

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Container(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.0, top: 50.0),
                  height: 50,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(widget.image),
                    backgroundColor: CommonColors.bottomgrey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.0, top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("Ana, 24",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        child: Text("Denmark",
                            style: TextStyle(color: Colors.white, fontSize: 12)),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  margin: EdgeInsets.only(left: 5.0, top: 50.0),
                  decoration: BoxDecoration(
                    color: CommonColors.buttonorg,
                    borderRadius: BorderRadius.all(Radius.circular(45.0))
                  ),
                  child: Text("+Follow",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600,),),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      color: Color(0xffFEDA14),
                      borderRadius: BorderRadius.all(
                          Radius.circular(5.0))
                  ),
                  child: Text("Join LIVE",
                    style: TextStyle(color: Color(0xff1E1E1E), fontSize: 11.0, fontWeight: FontWeight.w600),),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                              image: NetworkImage(widget.image),
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
                                child: Text("Ana, 24",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                              ),
                            ),
                          ]
                      )
                  ),
                ),
              ),
            ),
            Container(
              height: 250,
                child: Column(
                  children: [
                     Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            margin: EdgeInsets.only(left: 20, top: 20, right: 20 , bottom: 20.0),
                            child: TextField(
                              controller: search,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                    color: Colors.white
                                ),
                                prefixIcon: Icon(Icons.search,
                                  color: Colors.white,),
                              ),
                            ),
                          ),
                          Container(
                            child: Image.asset("assets/following.png"),
                          )
                        ],
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

}