import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class ChatRoom extends StatefulWidget {

  String image = "";

  ChatRoom(this.image);

  @override
  State<ChatRoom> createState() => _ChatRoom();

}

class _ChatRoom extends State<ChatRoom> {

  TextEditingController message = TextEditingController();

  var messageList = ["Hi","How are you",];
  var reciveList = ["Hello", "Fine"];
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: CommonColors.themeblack,
     body: Container(
       width: double.infinity,
       height: double.infinity,
       child: IntrinsicHeight(
         child: Column(
           children: [
             Container(
             margin: EdgeInsets.only(top: 40.0),
           height: 50,
           child: CircleAvatar(
             radius: 30,
             backgroundImage: NetworkImage(widget.image),
             backgroundColor: CommonColors.bottomgrey,
           ),
         ),

             Container(
               padding: const EdgeInsets.only(),
               child: Row(
                 children: [
                   Container(
                     margin: const EdgeInsets.only(left: 18.5),
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
                   Expanded(
                     child: Container(
                         alignment: Alignment.center,
                         margin: const EdgeInsets.only(right: 55, bottom: 10.0),
                         child:  Text(
                           "Nunito",
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                         )
                     ),
                   ),
                 ],
               ),
             ),
             Expanded(
                 child: Container(
                   child: Stack(
                     children: [
                       Positioned(
                         top: 10,
                         bottom: 100,
                         left: 0,
                         right: 0,
                         child: Container(
                           color: Color(0xffE3E3E3),
                           alignment: Alignment.bottomCenter,
                           margin: const EdgeInsets.only(),
                           child: ListView.builder(
                               shrinkWrap: false,
                               scrollDirection: Axis.vertical,
                               itemCount: messageList.length,
                               physics: AlwaysScrollableScrollPhysics(),
                               itemBuilder: (context, index){
                                 return Container(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.start,
                                         children: [
                                           Container(
                                             margin: EdgeInsets.only(top: 20.0),
                                             height: 50,
                                             child: CircleAvatar(
                                               radius: 30,
                                               backgroundImage: NetworkImage(widget.image),
                                               backgroundColor: CommonColors.bottomgrey,
                                             ),
                                           ),
                                           Container(
                                             margin: const EdgeInsets.only( right: 10, top: 10),
                                             padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                                             decoration: const BoxDecoration(
                                               color: Color(0xffFCFCFC),
                                               borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(20),
                                                   bottomRight: Radius.circular(20),
                                                   topRight: Radius.circular(20)),
                                             ),
                                             child: Container(
                                                   alignment: Alignment.centerLeft,
                                                   child: Text(messageList[index]),
                                                 ),
                                           ),
                                           Spacer(),
                                           Container(
                                             margin: EdgeInsets.only(right: 20.0),
                                             child: Icon(
                                               CupertinoIcons.heart_fill,
                                               color: Colors.white,
                                             ),
                                           ),
                                         ],
                                       ),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.end,
                                         children: [
                                           Container(
                                             alignment: Alignment.centerRight,
                                             margin: const EdgeInsets.only(
                                                 right: 10, top: 10),
                                             padding: const EdgeInsets.only(left: 10, top: 5, right: 20, bottom: 5),
                                             decoration: const BoxDecoration(
                                               color: Color(0xffFCFDFF),
                                               borderRadius: BorderRadius.only(
                                                   topLeft: Radius.circular(25),
                                                   bottomRight:
                                                   Radius.circular(25),
                                                   bottomLeft:
                                                   Radius.circular(25)),
                                             ),
                                             child: Container(
                                               alignment: Alignment.centerLeft,
                                               child: Text(
                                                 reciveList[index],
                                                 textAlign: TextAlign.start,
                                               ),
                                             ),
                                           ),
                                         ],
                                       )
                                     ],
                                   ),
                                 );
                               }),
                         ),
                       ),
                       Positioned(
                         right: 15,
                         left: 15,
                         bottom: 25,
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Expanded(
                                 child: Container(
                                   // width: double.infinity,
                                     decoration: BoxDecoration(
                                       color: const Color(0xffFFFFFF),
                                       borderRadius: BorderRadius.circular(30),
                                     ),
                                     alignment: Alignment.topLeft,
                                     child: Row(
                                       children: [
                                         Expanded(
                                             child: Container(
                                               margin: const EdgeInsets.only(
                                                   top: 0, right: 10, left: 10),
                                               child: TextField(
                                                 controller: message,
                                                 keyboardType: TextInputType.text,
                                                 maxLines: 1,
                                                 decoration: InputDecoration(
                                                   hintStyle: TextStyle(
                                                       fontSize: 13, fontWeight: FontWeight.w400,
                                                       color: Colors.black),
                                                   hintText: 'Type a message',
                                                   border: InputBorder.none,
                                                   // contentPadding:
                                                   // const EdgeInsets.all(20),
                                                 ),
                                               ),
                                             )
                                         ),
                                         Container(
                                           margin: EdgeInsets.only(right: 10.0),
                                           child: Text("Send",
                                           style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400,
                                           color: Colors.black),),
                                         ),

                                         // SizedBox(
                                         //   width: 10,
                                         // )
                                       ],
                                     )),
                               ),
                               Container(
                                 margin: EdgeInsets.only(bottom: 40.0, left: 10.0),
                                   child: Icon(
                                     Icons.mic_none,
                                     color: Color(0xffFFFFFF),
                                   ),
                                 ),
                             ],
                           ),
                       ),
                     ],
                   ),
                 ))
           ],
         ),
       ),
     ),
   );
  }

}