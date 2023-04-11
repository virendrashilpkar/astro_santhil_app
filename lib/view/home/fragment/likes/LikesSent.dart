import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/view/home/fragment/likes/fragments/TopPicks.dart';

import 'fragments/Likes.dart';

class LikesSent extends StatefulWidget {
  @override
  State<LikesSent> createState() => _LikesSentState();

}

class _LikesSentState extends State<LikesSent> with TickerProviderStateMixin{


  @override
  Widget build(BuildContext context) {

    TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
     backgroundColor: CommonColors.themeblack,
     body: SafeArea(
       child: Container(
         child: Column(
           children: [
             Container(
               height: 60,
               padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
               child: Container(
                 padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(
                       Radius.circular(20.0)),
                   color: Colors.white30,
                 ),
                 child: TabBar(
                   controller: _tabController,
                   labelColor: Colors.white,
                   unselectedLabelColor: Colors.black,
                   indicator: BoxDecoration(
                       borderRadius: BorderRadius.all(
                           Radius.circular(20.0)),
                       color: CommonColors.buttonorg
                   ),
                   tabs: [
                     Tab(
                       child: Container(
                         child: Text('Likes Sent'),
                       ),
                     ),
                     Tab(
                         child: Container(
                           child: Text('Top Picks'),
                     ))

                   ],
                 ),
               ),
             ),
             Expanded(
                 child: Container(
                   child: TabBarView(
                     controller: _tabController,
                     children: [
                       Likes(),
                       TopPicks()
                     ],
                   ),
                 )
             )
           ],
         ),
       ),
     ),
   );
  }

}