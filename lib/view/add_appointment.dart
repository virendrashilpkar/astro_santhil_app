import 'dart:io';

import 'package:astro_santhil_app/models/add_customer_model.dart';
import 'package:astro_santhil_app/models/category_model.dart';
import 'package:astro_santhil_app/models/sub_category_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/home.dart';
import 'package:astro_santhil_app/view/menu.dart';
import 'package:astro_santhil_app/view/slot_booking.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {

  List<String> gender = ["Male", "Female", "Other"];
  String selectedGender = "Male";
  List<String> categoryList = ["Select Category",];
  String selectedCategory = "Select Category";
  List<String> subCategoryList = ["Select Sub Category",];
  String selectedSubCategory = "Select Sub Category";
  String categoryId = "";
  String subCategoryId = "";
  File? image;
  File? horoscopeImage;
  late AddCustomerModel _addCustomerModel;
  late CategoryModel _categoryModel;
  late SubCategoryModel _subCategoryModel;
  TextEditingController userName = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController text = TextEditingController();
  TextEditingController birthPlace = TextEditingController();
  DateTime? date;
  String dob = "(DD/MM/YYYY)";
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay? picked;
  String selectTimes = "Select Slot";
  bool clickLoad = false;

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(
        context: context,
        initialTime: _time,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          );
        }
    );
    if(picked != null){
      setState(() {
        _time = picked!;
        print(picked);
        selectTimes = "${picked?.hour}:${picked?.minute}:${picked?.period.name.toUpperCase()}";
      });
    }
  }

  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            TextButton(
                child: Text("Camera"),
                onPressed: () {
                  _getFromCamera();
                  Navigator.pop(context);
                }
            ),
            TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  _getFromGallery();
                  Navigator.pop(context);
                }
            ),
          ]
      ),
    );
  }

  void _uplodHoroscopeImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            TextButton(
                child: Text("Camera"),
                onPressed: () {
                  _getHoroscopeFromCamera();
                  Navigator.pop(context);
                }
            ),
            TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  _getHoroscopeFromGallery();
                  Navigator.pop(context);
                }
            ),
          ]
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        image = File(pickedFile.path);
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        image = File(pickedFile.path);
      });

    }
  }

  void _viewHoroscopeImage() {
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: Text("View Horoscope Image", textAlign: TextAlign.center,),
          titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          content: horoscopeImage != null ?
          Image.file(horoscopeImage!):
          Text("Upload Horoscope Image First", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),

        ));
  }

  _getHoroscopeFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        horoscopeImage = File(pickedFile.path);
      });
    }
  }

  _getHoroscopeFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        horoscopeImage = File(pickedFile.path);
      });

    }
  }

  Future<void> categoryMethod() async {
    _categoryModel = await Services.categoryList();
    if(_categoryModel.status == true){
      for(var i=0; i < _categoryModel.body!.length; i++){
        categoryList.add(_categoryModel.body![i].catName.toString());
      }
    }
    setState(() {

    });
  }

  Future<void> subCategoryMethod() async {
    _subCategoryModel = await Services.subCategoryList(categoryId);
    if(_subCategoryModel.status == true){
      for(var i=0; i < _subCategoryModel.body!.length; i++){
        subCategoryList.add(_subCategoryModel.body![i].subCatName.toString());
      }
    }
    setState(() {

    });
  }

  Future<void> addCustomer() async {
    setState(() {
      clickLoad = true;
    });
    _addCustomerModel = await Services.customerAdd(userName.text,
        selectedGender, city.text, dob.toString(), selectTimes, email.text, phoneNumber.text,
        categoryId, subCategoryId, place.text, text.text, birthPlace.text, image!, horoscopeImage!);
    if(_addCustomerModel.status == true){
      Fluttertoast.showToast(msg: "${_addCustomerModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    }else{

      Fluttertoast.showToast(msg: "${_addCustomerModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {
      clickLoad = false;
    });
  }

  @override
  void initState() {
    categoryMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xff1BBF57),
                  Color(0xff34E389),
                ],)
          ),
          child: SafeArea(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => Menu()));
                            },
                            child: Container(
                              child: Image.asset("assets/drawer_ic.png",
                                width: 22.51,
                                height: 20.58,),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text("CUSTOMER DETAILS", style: TextStyle(color: Colors.white, fontSize: 21.61),),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 13.42,
                    ),
                     Container(
                        padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                        color: Colors.white,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Container(
                                 alignment: Alignment.center,
                                 child: InkWell(
                                   onTap: (){
                                     _pickedImage();
                                   },
                                   child: CircleAvatar(
                                    radius: 45.0,
                                    backgroundColor: Colors.black,
                                    child: ClipOval(
                                      child: image   != null ? Image.file(image!,
                                      height: 120,):
                                      Padding(
                                        padding: const EdgeInsets.only(top: 13.0),
                                        child: Image.asset("assets/user_ic.png",
                                        color: Colors.white,),
                                      ),
                                    ),
                                   ),
                                 )
                               ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text("Image"),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text("Name"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                  color: Color(0xffF8F8F9),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0)
                                  )
                                ),
                                child: TextField(
                                  controller: userName,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Name',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Gender"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF8F8F9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)
                                      )
                                  ),
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  underline: Container(
                                    width: 0,
                                  ),
                                  onChanged: (String? data){
                                    setState(() {
                                      selectedGender = data!;
                                    });
                                  },
                                  items: gender
                                      .map<DropdownMenuItem<String>>((String value){
                                        return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value)
                                        );
                                  }).toList(),
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Place"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: place,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Place',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("City"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: city,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'City',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                            child: Text("D.O.B"),
                                          ),
                                          InkWell(
                                            onTap: () async{
                                              date = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1950),
                                                  lastDate: DateTime.now());
                                              int? month = date?.month;
                                              String? fm=""+ "${month}";
                                              String? fd=""+"${date?.day}";
                                              if(month!<10){
                                                fm ="0"+"${month}";
                                                print("fm ${fm}");
                                              }
                                              if (date!.day<10){
                                                fd="0"+"${date?.day}";
                                                print("fd ${fd}");
                                              }
                                              if(date != null){
                                                print('Date Selecte : ${date?.day ??""}-${date?.month ??""}-${date?.year ??""}');
                                                setState(() {
                                                  dob ='${date?.year??""}-${fm}-${fd}';
                                                  print("selectedFromDate ${dob?.split(" ")[0]}");
                                                });
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 10.0),
                                              padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF8F8F9),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(5.0)
                                                  )
                                              ),
                                              child: Text(dob.toString(), style: TextStyle( color: Color(0xff6C7480),),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                              child: Text(
                                                  "Birth-Time"),
                                            ),
                                            InkWell(
                                              onTap: (){
                                                selectTime(context);
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF8F8F9),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(5.0)
                                                    )
                                                ),
                                                child: Text( selectTimes != null ? selectTimes:
                                                  "(00:00) AM", style: TextStyle(color: Color(0xff6C7480),),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Email"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: email,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Email',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Phone Number"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: phoneNumber,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Phone Number',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Category"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF8F8F9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          )
                                      ),
                                      child: DropdownButton<String>(
                                        value: selectedCategory,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        underline: Container(
                                          width: 0,
                                        ),
                                        onChanged: (String? data){
                                          setState(() {
                                            selectedCategory = data!;
                                            subCategoryList.clear();
                                            subCategoryList.add("Select Sub Category");
                                            selectedSubCategory = "Select Sub Category";
                                            if(selectedCategory != "Select Category"){
                                              for(var i = 0; i < _categoryModel.body!.length; i++){
                                                if(data == _categoryModel.body![i].catName) {
                                                  categoryId = _categoryModel.body![i].catId.toString();
                                                  subCategoryMethod();
                                                }
                                              }
                                            }
                                          });
                                        },
                                        items: categoryList
                                            .map<DropdownMenuItem<String>>((String value){
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value)
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      padding: EdgeInsets.only(left: 10.0),
                                      decoration: BoxDecoration(
                                          color: Color(0xffF8F8F9),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          )
                                      ),
                                      child: DropdownButton<String>(
                                        value: selectedSubCategory,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                        underline: Container(
                                          width: 0,
                                        ),
                                        onChanged: (String? data){
                                          setState(() {
                                            selectedSubCategory = data!;
                                            if(selectedSubCategory != "Select Sub Category"){
                                              for(var i = 0; i < _subCategoryModel.body!.length; i++){
                                                if(data == _subCategoryModel.body![i].subCatName) {
                                                  subCategoryId = _subCategoryModel.body![i].subCatId.toString();
                                                }
                                              }
                                            }

                                          });
                                        },
                                        items: subCategoryList
                                            .map<DropdownMenuItem<String>>((String value){
                                          return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value)
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Horscope Image"),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      _uplodHoroscopeImage();
                                    },
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                      padding: EdgeInsets.symmetric(horizontal: 47.62, vertical: 5.0 ),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff1C7069).withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 10), // changes position of shadow
                                            ),
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff00935D),
                                              Color(0xff1C7069)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          )
                                      ),
                                      child: Text("Upload".toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  InkWell(
                                    onTap: (){
                                      _viewHoroscopeImage();
                                    },
                                    child: Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                      padding: EdgeInsets.symmetric(horizontal: 47.62, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xff1C7069).withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0, 10), // changes position of shadow
                                            ),
                                          ],
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff00935D),
                                              Color(0xff1C7069)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)
                                          )
                                      ),
                                      child: Text("View".toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Birth-Place"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: birthPlace,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Birth-Place',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                child: Text("Your Text"),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    color: Color(0xffF8F8F9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5.0)
                                    )
                                ),
                                child: TextField(
                                  controller: text,
                                    textAlignVertical: TextAlignVertical.center,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Your Text',
                                      hintStyle: const TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xff6C7480),
                                      ),
                                      border: InputBorder.none,
                                    )
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  if(image == null){
                                    Fluttertoast.showToast(msg: "Upload image");
                                  }else if(userName.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter name");
                                  }else if(place.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter place");
                                  }else if(city.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter city");
                                  }else if(dob == "(DD/MM/YYYY)"){
                                    Fluttertoast.showToast(msg: "Enter Date of bith");
                                  }else if(selectTimes == "Select Slot"){
                                    Fluttertoast.showToast(msg: "Enter time");
                                  }else if(email.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter email");
                                  }else if(phoneNumber.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter phone number");
                                  }else if(selectedCategory == "Select Category"){
                                    Fluttertoast.showToast(msg: "Select Category");
                                  }else if(selectedSubCategory == "Select Sub Category"){
                                    Fluttertoast.showToast(msg: "Select Sub Category");
                                  }else if(birthPlace.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter birth place");
                                  }else if(text.text.isEmpty){
                                    Fluttertoast.showToast(msg: "Enter text");
                                  }else {
                                    addCustomer();
                                  }
                                },
                                child: Container(
                                  height: 60,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                  padding: EdgeInsets.symmetric(horizontal: 12.75, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xff1BBF57).withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0, 10), // changes position of shadow
                                        ),
                                      ],
                                    gradient: LinearGradient(
                                        colors: [
                                          Color(0xff1BBF57),
                                          Color(0xff34E389)
                                        ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)
                                    )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      clickLoad?Container(
                                        width: 24,
                                        height: 24,
                                        padding: const EdgeInsets.all(2.0),
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 3,
                                        ),
                                      ):Text("Save Changes".toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)
                                      )
                                    ],
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}