import 'dart:io';

import 'package:astro_santhil_app/view/add_appointment.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'menu.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {


  late File image = File("");
  late File horoscopeImage = File("") ;

  void _pickedImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text("Choose image source"), actions: [
            TextButton(
                child: Text("Camera"),
                onPressed: () {
                  _getFromCamera();
                  Navigator.pop(context);
                }),
            TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  _getFromGallery();
                  Navigator.pop(context);
                }),
          ]),
    );
  }

  void _uplodHoroscopeImage() {
    showDialog<ImageSource>(
      context: context,
      builder: (context) =>
          AlertDialog(content: Text("Choose image source"), actions: [
            TextButton(
                child: Text("Camera"),
                onPressed: () {
                  _getHoroscopeFromCamera();
                  Navigator.pop(context);
                }),
            TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  _getHoroscopeFromGallery();
                  Navigator.pop(context);
                }),
          ]),
    );
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  _getHoroscopeFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
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
      setState(() {
        horoscopeImage = File(pickedFile.path);
      });
    }
  }
  
  void _viewHoroscopeImage() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "View Horoscope Image",
            textAlign: TextAlign.center,
          ),
          titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          content: horoscopeImage != null
              ? Image.file(horoscopeImage!)
              : Text(
            "Upload Horoscope Image First",
            style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color(0xFF009688),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  )),
              child: Container(
                padding: EdgeInsets.only(top: 30, bottom: 10),
                margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Menu("Home")));
                      },
                      child: Container(
                        child: Image.asset(
                          "assets/drawer_ic.png",
                          width: 22.51,
                          height: 20.58,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Text(
                        "Upload Images",
                        style:
                        TextStyle(color: Colors.white, fontSize: 21.61),
                      ),
                    ),
                    Spacer(),
                    // Container(
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Icon(
                    //       Icons.home,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Container(

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: Offset(5, 5),
                              )
                            ]
                        ),
                        child: InkWell(
                          onTap: () {
                            _pickedImage();
                          },
                          child: image == null || image.path.isEmpty
                              ? ClipRRect(
                            borderRadius:
                            BorderRadius.circular(50.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Color(0xff009688),
                              child: Image.asset(
                                "assets/Group 48.png",
                                color: Colors.white,
                                // height: 100.0,
                                // width: 100.0,
                                // fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : ClipRRect(
                              borderRadius:
                              BorderRadius.circular(50.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.file(
                                  File(image!.path),
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Text("Image",
                          style: TextStyle(
                            color: Color(0xFF8A92A2),
                            fontSize: 13.55,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text("Horscope Image",
                          style: TextStyle(
                            color: Color(0xFF8A92A2),
                            fontSize: 13.55,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _uplodHoroscopeImage();
                            },
                            child: Container(
                              height: 45,
                              alignment: Alignment.center,
                              // margin: EdgeInsets.only(
                              // top: 20.0, bottom: 20.0),
                              // padding: EdgeInsets.symmetric(
                              //     horizontal: 47.62, vertical: 5.0),
                              decoration: ShapeDecoration(
                                color: Color(0xFF526872),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/Icon-Color.png"),
                                  SizedBox(width: 5.0,),
                                  Text(
                                    'UPLOAD',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: InkWell(
                              onTap: () {
                                _viewHoroscopeImage();
                              },
                              child: Container(
                                height: 45,
                                // alignment: Alignment.center,
                                // margin: EdgeInsets.only(
                                //     top: 20.0, bottom: 20.0),
                                // padding: EdgeInsets.symmetric(
                                //     horizontal: 47.62, vertical: 5.0),
                                decoration: ShapeDecoration(
                                  color: Color(0xFF526872),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/Group 36.png"),
                                    SizedBox(width: 5.0,),
                                    Text(
                                      'VIEW',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )                                        ],
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddAppointment("", "", image, horoscopeImage)));
                },
                child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    margin:
                    EdgeInsets.only(top: 20.0, bottom: 20.0),
                    padding: EdgeInsets.symmetric(
                        horizontal: 12.75, vertical: 5.0),
                    decoration: ShapeDecoration(
                      color: Color(0xFF009688),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )),
              ),
            )

          ],
        ),
      ),
    );
  }
}
