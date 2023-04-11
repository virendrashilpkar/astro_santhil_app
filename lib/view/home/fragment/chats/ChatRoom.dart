import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class ChatRoom extends StatefulWidget {

  String image = "";

  ChatRoom(this.image);

  @override
  State<ChatRoom> createState() => _ChatRoom();

}

class _ChatRoom extends State<ChatRoom> {
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
               alignment: Alignment.center,
                   // margin: const EdgeInsets.only(top: 13),
                  child:  Text(
                     "Nunito",
                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
                   )
               ),
             Container(
               padding: const EdgeInsets.only(
                   top: 10, ),
               child: Row(
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

                 ],
               ),
             ),
           ],
         ),
       ),
     ),
   );
  }

}