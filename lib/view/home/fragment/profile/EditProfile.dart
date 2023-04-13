import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayout.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';


class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditProfile> with SingleTickerProviderStateMixin{

  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } catch (Error) {
      // setState(() {
      ActiveConnection = false;
      T = "Turn On the data and repress again";
      // });
    }
  }
  String youarevalue="";

  List<File?> imagelist = List.filled(6, null);
  // List<File?> imagelist=[null,null,null,null,null,null];
 late TabController _tabController;



  List<String> tags = [
    'travel',
    'foodie',
    'fitness',
    'photography',
    'nature',
    'fashion',
    'beauty',
    'health',
    'motivation',
    'entrepreneur',
    'pets',
    'music',
    'art',
    'books',
    'technology',
    'education',
    'cooking',
    'gaming',
    'humor',
    'sports',
    'finance',
    'selfcare',
    'parenting',
    'politics',
    'spirituality'
  ];

  List<String> regions = [
    'Hindu',
    'Sikh',
    'Jain',
    'Muslim',
    'Christian',
    'Budhist',
    'Doesnt matter'
  ];

  List<int> selectedIndex = [];
  List<int> selectedIndexregion = [];

  TextEditingController tagsearch = TextEditingController();


  @override
  void initState() {
    CheckUserConnection();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  void _pickedImage(int index) {
    showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
          content: Text("Choose image source"),
          actions: [
            TextButton(
                child: Text("Camera"),
                onPressed: () {
                  _getFromCamera(index);
                  Navigator.pop(context);
                }
            ),
            TextButton(
                child: Text("Gallery"),
                onPressed: () {
                  _getFromGallery(index);
                  Navigator.pop(context);
                }
            ),
          ]
      ),
    );
  }

  _getFromGallery(int index) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        imagelist[index] = File(pickedFile.path);
      });
    }
  }
  _getFromCamera(int index) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState((){
        imagelist[index] = File(pickedFile.path);
      });

    }
  }

  bool PhotoOptions=false;
  int ischeck=100;
  int ischeckregion=100;


  String country = 'Select country';
  String city = 'Select city';
  String caste = 'Select Caste';
  String tongue = 'Select your mother tongue';
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new SizedBox(height: MediaQuery.of(context).padding.top+20,),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
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
                new Spacer(),
                new Text("Edit info",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                new Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 40,),
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: CommonColors.buttonorg,
                ),
                labelColor: CommonColors.white,
                unselectedLabelColor: CommonColors.themeblack,
                unselectedLabelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),
                labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Edit',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Preview',
                  ),
                ],
              ),
            ),
            new SizedBox(height: 30,),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  SingleChildScrollView(
                    child: Column(
                      children: [

                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Change photos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        new SizedBox(height: 10,),
                        new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: new GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (itemWidth / itemHeight),
                            controller: new ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: List.generate(imagelist.length, (index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: CommonColors.themeblack,
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  border: imagelist[index] != null ?  null : Border.all(color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[

                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: imagelist[index] == null ? Image.asset(
                                          "assets/add_photos.png",
                                          fit: BoxFit.cover,
                                          // height: itemHeight,
                                          // width: itemWidth,
                                        ):Image.file(imagelist[index]!,fit: BoxFit.cover,
                                          height: itemHeight,
                                          width: itemWidth,)
                                    ),
                                    SizedBox.expand(
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(onTap: () {
                                          _pickedImage(index);
                                        },splashColor: Colors.blue.withOpacity(0.2),
                                          customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if(imagelist[index] != null) new Positioned(
                                      right:0,
                                      top:0,
                                      child: SizedBox(
                                        height:30,
                                        width:30,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(onTap: () {
                                            setState((){
                                              imagelist[index]=null;
                                            });
                                          },splashColor: Colors.blue.withOpacity(0.2),
                                            customBorder: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            child:  Container(
                                                decoration: BoxDecoration(
                                                  // color: Colors.white,
                                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                ),
                                                child: Icon(Icons.close,color: Colors.white,)),
                                          ),
                                        ),
                                      ),),

                                  ],
                                ),
                              );
                            }
                              // imagelist.map((File? value) {
                              //   return Container(
                              //     // height: 100,
                              //     // margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                              //     decoration: BoxDecoration(
                              //       // color: youarevalue == value ? CommonColors.buttonorg:CommonColors.themeblack ,
                              //       borderRadius: const BorderRadius.all(Radius.circular(5)),
                              //       border: value != null ?  null : Border.all(color: Colors.white),
                              //     ),
                              //     child: Stack(
                              //       alignment: Alignment.center,
                              //       children: <Widget>[
                              //         ClipRRect(
                              //           borderRadius: BorderRadius.circular(5.0),
                              //           child: Image.asset(
                              //             "assets/add_photos.png",
                              //             // height: 150.0,
                              //             // width: 100.0,
                              //           ),
                              //         ),
                              //         SizedBox.expand(
                              //           child: Material(
                              //             type: MaterialType.transparency,
                              //             child: InkWell(onTap: () {
                              //               _pickedImage()
                              //             },splashColor: Colors.blue.withOpacity(0.2),
                              //               customBorder: RoundedRectangleBorder(
                              //                 borderRadius: BorderRadius.circular(25),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   );
                              // }).toList(),
                            ),
                          ),
                        ),


                        new SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'The first photo is your profile photo',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        new SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Photo Options",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        new SizedBox(height: 10,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Smart Photos",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.editblackgrey),),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'Smart Photos continuously tests all your profile photos and picks the best one to show first.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        new SizedBox(height: 25,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            new SizedBox(width: 30,),
                            new Container(
                              child: Text("Get verified",style: new TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color:Colors.white),),
                            ),
                            new SizedBox(width: 10,),
                            SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset("assets/blue_tick.png",height: 25,width: 25,fit: BoxFit.cover,),
                            )
                          ],
                        ),
                        new SizedBox(height: 15,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Take a selfie",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.editblackgrey),),
                              ),
                              new Spacer(),
                              new Container(
                                  child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        new SizedBox(height: 15,),
                        new Container(
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          alignment: Alignment.centerLeft,
                          child: new Text("About me",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.editblackgrey),),
                        ),

                        new SizedBox(height: 15,),

                        Container(
                          height: 260,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: CommonColors.editblackgrey,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(17)),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: '',
                              border: InputBorder.none,
                              hintStyle: new TextStyle(color: Colors.black.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            style: new TextStyle(color: Colors.black,fontSize: 14),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Tag';
                              }
                              return null;
                            },
                          ),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Interests",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),



                        new SizedBox(height: 10,),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            controller: tagsearch,
                            decoration: InputDecoration(
                                hintText: 'Add New Tag...',
                                border: InputBorder.none,
                                hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                                prefixIcon: SizedBox(child: Image.asset("assets/tag_intrests.png"),),
                                suffixIcon: new InkWell(
                                  onTap: (){
                                    if(selectedIndex.length!=4){
                                      setState((){
                                        tags.add(tagsearch.text!);
                                        selectedIndex.add(tags.length-1);
                                      });
                                    }else{
                                      Toaster.show(context, "You can select only 4");
                                    }
                                  },
                                  child: SizedBox(child: Icon(Icons.done,color: Colors.cyan,),),
                                )
                            ),
                            style: new TextStyle(color: Colors.white,fontSize: 14),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Tag';
                              }
                              return null;
                            },
                          ),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 27),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                tags.length,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(selectedIndex.length!=4){
                                        selectedIndex.add(index);
                                      }else{
                                        Toaster.show(context, "You can select only 4");
                                      }
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: selectedIndex.contains(index) ? CommonColors.buttonorg : null,
                                        borderRadius: BorderRadius.circular(65),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("${tags[index]}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                                          new SizedBox(width: 5,),
                                          new SizedBox(
                                            child: InkWell(onTap: (){
                                              setState(() {
                                                selectedIndex.remove(index);
                                              });
                                            },child: Padding(
                                              padding: const EdgeInsets.all(0.0),
                                              child: Icon(Icons.close,color: Colors.white,),
                                            )),
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        new SizedBox(height: 20,),
                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Profile managed by ",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                               Row(
                                  children: [
                                    // new SizedBox(width: 20,),
                                    ischeck==1 ? InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=100;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: CommonColors.blueloc,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                                      ),
                                    ):
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=1;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                      ),),
                                    new SizedBox(width: 5,),
                                    new Container(
                                      child: new Text("Self",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                                    ),
                                  ],
                               ),
                              // new SizedBox(width: 20,),
                              Spacer(),
                               Row(
                                  children: [
                                    // new SizedBox(width: 20,),
                                    ischeck==2 ? InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=100;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: CommonColors.blueloc,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                                      ),
                                    ):
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=2;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                      ),),
                                    new SizedBox(width: 5,),
                                    new Container(
                                      child: new Text("Sibling",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                                    ),
                                  ],
                                ),
                              Spacer(),
                              // new SizedBox(width: 20,),
                               Row(
                                  children: [
                                    // new SizedBox(width: 20,),
                                    ischeck==3 ? InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=100;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: CommonColors.blueloc,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                                      ),
                                    ):
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          ischeck=3;
                                        });
                                      },
                                      child: new Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                      ),),
                                    new SizedBox(width: 5,),
                                    new Container(
                                      child: new Text("Parents",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        new SizedBox(height: 15,),
                        new Container(
                          margin: const EdgeInsets.only(left: 37,right: 37),
                          alignment: Alignment.centerLeft,
                          child: new Text("Marriage plan",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 15,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                  child: Image.asset("assets/within.png")
                              ),
                              new SizedBox(width: 5,),
                              new Container(
                                child: new Text("Within",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.editblackgrey),),
                              ),
                              new Spacer(),
                              new Container(
                                  child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 50,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          alignment: Alignment.centerLeft,
                          child: Text("Basic info",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                        new SizedBox(height: 20,),
                        Customlayout(icon: 'assets/zodiac_icon.png',tittle: 'Zodiac',status: 'Libra',),
                        Customlayout(icon: 'assets/education_bottom.png',tittle: 'Education',status: 'Master degree',),
                        Customlayout(icon: 'assets/covid_bottom.png',tittle: 'COVID vaccine',status: 'Not added',),
                        Customlayout(icon: 'assets/health_bottom.png',tittle: 'Health',status: 'Not added',),
                        Customlayout(icon: 'assets/persional_bottom.png',tittle: 'Personality type',status: 'Add',),

                        new SizedBox(height: 40,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Lifestyle",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 20,),
                        Customlayout(icon: 'assets/pet_icon.png',tittle: 'Pets',status: 'Dog',),
                        Customlayout(icon: 'assets/drink_bottom.png',tittle: 'Drinking',status: 'On special occasions',),
                        Customlayout(icon: 'assets/smoke_bottom.png',tittle: 'Smoking',status: 'Non-smoker',),
                        Customlayout(icon: 'assets/workout_bottom.png',tittle: 'Workout',status: 'Often',),
                        Customlayout(icon: 'assets/dientary_bottom.png',tittle: 'Dietary preference',status: 'Not added',),
                        Customlayout(icon: 'assets/social_bottom.png',tittle: 'Social media',status: 'Socially active',),
                        Customlayout(icon: 'assets/sleep_bottom.png',tittle: 'Sleeping habits',status: 'Early bird',),

                        new SizedBox(height: 20,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Job Title",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 15,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: 'Digital Marketing',
                                border: InputBorder.none,
                                hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            style: new TextStyle(color: Colors.white,fontSize: 14),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Tag';
                              }
                              return null;
                            },
                          ),
                        ),
                        new SizedBox(height: 20,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Company",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 15,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: 'Add Company',
                                border: InputBorder.none,
                                hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            style: new TextStyle(color: Colors.white,fontSize: 14),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Tag';
                              }
                              return null;
                            },
                          ),
                        ),
                        new SizedBox(height: 20,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Education",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 15,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                hintText: 'Add University',
                                border: InputBorder.none,
                                hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                            ),
                            style: new TextStyle(color: Colors.white,fontSize: 14),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your Tag';
                              }
                              return null;
                            },
                          ),
                        ),

                        new SizedBox(height: 15,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Living In",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        new SizedBox(height: 15,),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: CommonColors.editblack,
                            // border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: DropdownButton<String>(
                            value: country,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                country = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Select country', 'india', 'pakistan', 'china'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select country', 'india', 'pakistan', 'china'] // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),

                        new SizedBox(height: 15,),
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: CommonColors.editblack,
                            // border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: DropdownButton<String>(
                            value: city,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                city = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Select city', 'indore', 'bhopal', 'guna'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select city', 'indore', 'bhopal', 'guna'] // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),
                        new SizedBox(height: 25,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Religion",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        new SizedBox(height: 10,),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 27),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                regions.length,
                                    (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if(ischeckregion==index){
                                        ischeckregion=100;
                                      }else{
                                        ischeckregion=index;
                                      }
                                      // if(selectedIndexregion.length!=4){
                                      //   selectedIndexregion.add(index);
                                      // }else{
                                      //   Toaster.show(context, "You can select only 4");
                                      // }
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(3),
                                      // decoration: BoxDecoration(
                                      //   border: Border.all(color: Colors.white),
                                      //   color: selectedIndexregion.contains(index) ? CommonColors.buttonorg : null,
                                      //   borderRadius: BorderRadius.circular(65),
                                      // ),
                                      padding: EdgeInsets.all(3),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ischeckregion==index ? new Container(
                                      height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: CommonColors.blueloc,
                                            borderRadius: BorderRadius.circular(3)
                                        ),
                                        child: Icon(Icons.check,size: 20,color: Colors.white,),
                                      ):
                                          new Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(3)
                                            ),
                                          ),
                                          new SizedBox(width: 5,),
                                          new Container(
                                            child: new Text("${regions[index]}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        new SizedBox(height: 25,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Caste",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          // decoration: BoxDecoration(
                          //   color: CommonColors.editblack,
                          //   // border: Border.all(color: Colors.white),
                          //   borderRadius: const BorderRadius.all(Radius.circular(25)),
                          // ),
                          child: DropdownButton<String>(
                            value: caste,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                caste = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Select Caste', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: caste== "Select Caste" ?Colors.grey: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select Caste', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'] // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),
                        new SizedBox(height: 0,),
                        new Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("If you do not select caste, you will be shown all matches within your search requirements",style: new TextStyle(fontSize: 11,fontWeight: FontWeight.w400,color: CommonColors.white.withOpacity(0.6)),),
                        ),

                        new SizedBox(height: 30,),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Mother tongue",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          // decoration: BoxDecoration(
                          //   color: CommonColors.editblack,
                          //   // border: Border.all(color: Colors.white),
                          //   borderRadius: const BorderRadius.all(Radius.circular(25)),
                          // ),
                          child: DropdownButton<String>(
                            value: tongue,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                tongue = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Select your mother tongue', 'Hindi', 'English'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: tongue== "Select your mother tongue" ?Colors.grey: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select your mother tongue', 'Hindi', 'English'] // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),
                        new SizedBox(height: 20,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Characteristics",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 17,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Age",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        new SizedBox(height: 14,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Height",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        new SizedBox(height: 14,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Weight",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        new SizedBox(height: 14,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Smoke",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),



                        new SizedBox(height: 14,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Drink",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        new SizedBox(height: 14,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Diet",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        new SizedBox(height: 30,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Record voice message",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Add a voice message to your profile",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                  child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 12,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Instagram Photos",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new SizedBox(width: 20,
                              height:20,
                                child:Image.asset("assets/instagram.png")
                              ),
                              new SizedBox(width: 15,),
                              new Container(
                                child: new Text("Connect Instagram",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: new Text("Connect",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: CommonColors.white),),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 12,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Spotify Anthem",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new SizedBox(width: 20,
                              height:20,
                                child:Image.asset("assets/spotify.png")
                              ),
                              new SizedBox(width: 15,),
                              new Container(
                                child: new Text("Choose anthem",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: new Text("Connect",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: CommonColors.white),),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 12,),
                        new Container(
                          alignment:Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: new Text("Top Spotify Artists",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 10,),
                        Container(
                          height:50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              color: CommonColors.editblack,
                              borderRadius: BorderRadius.circular(37)
                          ),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new SizedBox(width: 20,
                              height:20,
                                child:Image.asset("assets/spotify.png")
                              ),
                              new SizedBox(width: 15,),
                              new Container(
                                child: new Text("Connect Spotify",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Container(
                                child: new Text("Connect",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: CommonColors.white),),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        new SizedBox(height: 40,),

                      ],
                    ),
                  ),

                  // second tab bar view widget
                  Center(
                    child: Text("Comming soon",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),


          ],
        ),
      )
    );
  }
}

