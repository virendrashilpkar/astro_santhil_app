import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/Models/DropdownModel.dart';
import 'package:shadiapp/Services/Services.dart';

class Customlayout extends StatefulWidget {
  final String icon;
  final String title;
  String selectedItem;
  final String dropdownItems;
  final Function(String) onDropdownChanged;
  final Function(String) onDropdownChanged2;

  Customlayout({
    required this.icon,
    required this.title,
    required this.selectedItem,
    required this.dropdownItems,
    required this.onDropdownChanged,
    required this.onDropdownChanged2,
  });

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<Customlayout> {


  @override
  void initState() {
    if(widget.dropdownItems.isNotEmpty) {
      Dropdown();
    }
  }
  late List<String> dropdownList=[];
  late List<String> dropdownListId=[];
  late DropdownModel _dropdownList;
  void Dropdown()async{
    _dropdownList = await Services.DropdownList(widget.dropdownItems);
    if(_dropdownList.data!.isNotEmpty){
      dropdownList.add("Add");
      dropdownListId.add("0");
      for(Datum item in _dropdownList.data ?? []){
        dropdownList.add(item.title ?? "");
        dropdownListId.add(item.id ?? "");
      }
    }
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.custombottom,
      padding: EdgeInsets.symmetric(horizontal: 30,vertical:dropdownList.isNotEmpty ? 5:14),
      margin: const EdgeInsets.only(top: 1),
      child: Row(
        children: [
          new SizedBox(height: 20,width:20,child: Image.asset("${widget.icon}",height: 20,width: 20,)),
          new SizedBox(width: 17,),
          new Container(
              child:Text("${widget.title}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
          ),
          new Spacer(),
          DropdownButton<String>(
            value: dropdownList.isEmpty || widget.selectedItem=="null" || widget.selectedItem=="" /*|| !dropdownList.contains(widget.dropdownItems)*/ ? "Add":widget.selectedItem,
            underline: Container(),
            items: dropdownList.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item,style: TextStyle(
                  color: Colors.black87, // Customize the text color here
                )),
              );
            }).toList(),
            selectedItemBuilder: (BuildContext context) {
              return dropdownList.map<Widget>((String item) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      item,
                      style: TextStyle(
                        color: Colors.white, // Specify the desired color for selected value here
                      ),textAlign: TextAlign.right,
                    ),
                  ),
                );
              }).toList();
            },
            alignment: Alignment.centerRight,
            style: TextStyle(color: Colors.white,),
            onChanged: (String? newValue) {
              setState(() {
                for(var i=0; i < dropdownList.length; i++){
                  if(dropdownList[i]==newValue){
                    widget.selectedItem = newValue!;
                    widget.onDropdownChanged(newValue);
                    widget.onDropdownChanged2(dropdownListId[i]);
                  }
                }

              });
            },
          ),
          // new Container(
          //     child:Text("${status}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),)
          // ),
        ],
      ),
    );
  }



}
