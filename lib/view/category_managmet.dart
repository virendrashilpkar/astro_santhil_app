import 'package:flutter/material.dart';

class CategoryManagement extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CategoryManagement();
}

class _CategoryManagement extends State<CategoryManagement>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Coming Soon", style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600
        ),),
      ),
    );
  }

}