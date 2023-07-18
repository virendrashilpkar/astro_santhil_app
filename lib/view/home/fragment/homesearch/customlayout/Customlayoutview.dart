import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class CustomlayoutView extends StatelessWidget {
  CustomlayoutView({required this.icon, required this.tittle,required this.status});
  final String tittle;
  final String status;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.custombottom,
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 14),
      margin: const EdgeInsets.only(top: 1),
      child: Row(
        children: [
          new SizedBox(height: 20,width:20,child: Image.asset("${icon}",height: 20,width: 20,)),
          new SizedBox(width: 17,),
          new Container(
              child:Text("${tittle}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
          ),
          new Spacer(),
          new Container(
              child:Text("${status}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
          ),
        ],
      ),
    );
  }
}