import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';

class Customcheck extends StatelessWidget {
  Customcheck({required this.tittle,required this.color,required this.textcolor});
  final String tittle;
  final Color color;
  final Color textcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: color,
          // border: Border.all(width: 1,color: Colors.white),
          borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          new Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
                // color: Colors.white,
                border: Border.all(width: 2,color: textcolor),
                borderRadius: BorderRadius.circular(4)
            ),
            child: Icon(Icons.check,size: 20,color: textcolor,),
          ),
          new SizedBox(width: 8,),
          new Container(
              child:Text("${tittle}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: textcolor),)
          ),
          new Spacer(),
        ],
      ),
    );
  }
}