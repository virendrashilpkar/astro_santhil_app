import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/view/home/Home.dart';
import 'package:shadiapp/view/home/fragment/chats/ChatRoom.dart';

class Match extends StatefulWidget {
  String id;
  String image;
  String user_image;
  String full_name;
  Match(this.image,this.user_image,this.id,this.full_name);

  @override
  State<Match> createState() => _MatchState();

}

class _MatchState extends State<Match> {

  TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(">>>>${widget.id}");
    print(">>>>${widget.image}");
    print(">>>>${widget.user_image}");
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 120.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset("assets/gold_star.png"),
                    ),
                    Container(
                      child: Image.asset("assets/gold_star.png"),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 50.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(60.0)
                        ),
                        border: Border.all(
                            color: CommonColors.buttonorg,
                            width: 3.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:100,
                          width: 100,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child:  ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network("${widget.image}",
                                width: 100,height: 100,fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height:100,
                          width: 100,
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network("${widget.user_image}",
                                width: 100,height: 100,fit: BoxFit.cover,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text("CONGRATS IT'S",
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: Text("A MATCH",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 40.0, right: 20.0, bottom: 10.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(30.0)),
                      color: Colors.white,
                    ),
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            // height: 50,
                            // margin: EdgeInsets.only(top: 5.0, left: 5.0),
                            // alignment: Alignment.center,
                            child: TextFormField(
                              maxLines: 1,
                              controller: _message,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  counterText: "",
                                  hintText: "send a message"
                              ),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          new InkWell(
                            onTap: () {

                              // addCustomPrefs(tagsearch.text!);

                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom(widget.user_image,widget.id,widget.id,widget.full_name,_message.text)
                                  )
                              );
                            },
                            child: SizedBox(
                              child: Icon(
                                Icons.done,
                                color: Colors.cyan,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 40,right: 50,left: 50),
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
                                child: Text("Keep swiping", style: TextStyle(
                                    color: Colors.white, fontSize: 20),),
                              )),
                        ],
                      ),
                      SizedBox.expand(
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => Home()));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}