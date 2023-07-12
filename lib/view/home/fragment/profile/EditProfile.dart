import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/city_list_model.dart';
import 'package:shadiapp/Models/country_list_model.dart';
import 'package:shadiapp/Models/delete_image_model.dart';
import 'package:shadiapp/Models/preference_list_model.dart';
import 'package:shadiapp/Models/upload_image_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Models/user_view_preference_model.dart';
import 'package:shadiapp/Models/view_image_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayout.dart';
import 'package:shadiapp/view/home/fragment/profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';


class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EditProfile> with SingleTickerProviderStateMixin{

  bool ActiveConnection = false;
  bool isLoad = false;
  bool clickLoad = false;
  String T = "";
  List<ImageDatum> _list = [];
  List<PrefsDatum> intrest = [];
  late SharedPreferences _preferences;
  late ViewImageModel _viewImageModel;
  late UploadImageModel _uploadImageModel;
  late UserViewPreferenceModel _viewPreferenceModel;
  late UserDetailModel _userDetailModel;
  late UpdateUserModel _updateUserModel;
  late PreferenceListModel _preferenceListModel;
  late DeleteImageModel _deleteImageModel;
  String firstName = "";
  String lastName = "";
  String dateOfBirth = "";
  String gender = "";
  String height = "";
  String weight = "";
  String maritalStatus = "";
  String email = "";
  String lookingFor = "";
  String religion = "";
  TextEditingController about = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController company = TextEditingController();
  TextEditingController education = TextEditingController();

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

  Future<void> viewImage() async {
    isLoad = true;
    _preferences = await SharedPreferences.getInstance();
    _viewImageModel = await Services.ImageView("${_preferences?.getString(ShadiApp.userId).toString()}");
    if(_viewImageModel.status == 1) {
      for(var i = 0; i < _viewImageModel.data!.length; i++){
        _list = _viewImageModel.data ?? <ImageDatum> [];
      }
    }
    isLoad = false;
    setState(() {

    });
  }

  Future<void> uploadImage(File image) async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _uploadImageModel = await Services.ImageUpload(image, "${_preferences?.getString(ShadiApp.userId).toString()}");
    if(_uploadImageModel.status == 1){
      Toaster.show(context, _uploadImageModel.message.toString());

    }else{
      Toaster.show(context, _uploadImageModel.message.toString());
    }
    setState(() {
      clickLoad = false;
    });
  }

  Future<void> deleteImage(String imageId) async {
    isLoad = true;
    _deleteImageModel = await Services.DeleteImage(imageId);
    if(_deleteImageModel.status == 1){
      Toaster.show(context, _deleteImageModel.message.toString());
      viewImage();
    }else{
      Toaster.show(context, _deleteImageModel.message.toString());
    }
    isLoad = false;
    setState(() {

    });
  }

  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      dateOfBirth = _userDetailModel.data![0].birthDate.toString();
      gender = _userDetailModel.data![0].gender.toString();
      country = _userDetailModel.data![0].country.toString();
      if(country!=""){
        ListCountry();
      }
      city = _userDetailModel.data![0].city.toString();
      state = _userDetailModel.data![0].state.toString();
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
      religion = _userDetailModel.data![0].religion.toString();
      caste = _userDetailModel.data![0].caste.toString();
      about.text = _userDetailModel.data![0].about.toString();
      education.text = _userDetailModel.data![0].education.toString();
      company.text = _userDetailModel.data![0].company.toString();
      jobTitle.text = _userDetailModel.data![0].jobTitle.toString();

      setState(() {

      });
    }
  }

  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser("${_preferences?.getString(ShadiApp.userId)}", firstName,
        lastName, dateOfBirth, gender, country, city,state ,height, weight, maritalStatus, email, lookingFor,
        religion, caste, about.text, education.text, company.text, jobTitle.text);
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Profile()));
    }else{
      Toaster.show(context, _updateUserModel.message.toString());
    }
    setState(() {
      clickLoad = false;
    });
  }

  List<prefsDatum> prefList = [];

  Future<void> viewPrefs() async {
    isLoad = true;
    _preferences = await SharedPreferences.getInstance();
    _preferenceListModel = await Services.PrefView("${_preferences?.getString(ShadiApp.userId).toString()}");
    if(_preferenceListModel.status == 1){
      for(var i = 0; i < _preferenceListModel.data!.length; i++){
        prefList = _preferenceListModel.data ?? <prefsDatum> [];
      }
    }
    isLoad = false;
    setState(() {

    });
  }

  Future<void> userViewPreference() async {
    _preferences = await SharedPreferences.getInstance();
    _viewPreferenceModel = await Services.ViewUserPreference(_preferences.getString(ShadiApp.userId).toString());
    if(_viewPreferenceModel.status == 1){
      for (int i = 0; i < _viewPreferenceModel.data!.length; i++){
        intrest = _viewPreferenceModel.data ?? <PrefsDatum> [];
      }
      intrest.forEach((element) {
        if (prefList.contains(element)){
          print("ahsdjfsdhfjshfs ${element.preference}");
        }
      });
    }
    setState(() {

    });
  }

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
    ListCountry();
    viewImage();
    userDetail();
    viewPrefs();
    userViewPreference();
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
        uploadImage(File(pickedFile.path));
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
        uploadImage(File(pickedFile.path));
      });

    }
  }

  bool PhotoOptions=false;
  int ischeck=100;
  int ischeckregion=100;
  bool ischeck2 =false;

  String country = 'Select country';
  String city = 'Select city';
  String state = 'Select state';
  List<String> cityList = [
    "Select city"
  ];
  List<String> countryList = [
    "Select country"
  ];
  late CountryListModel _countryListModel;
  late CItyListModel _cItyListModel;
  Future<void> ListCity(String name) async {
    setState(() {
      isLoad = true;
    });
    cityList.clear();
    _cItyListModel = await Services.CityList(name,"","");
    if(_cItyListModel.status == true){
      cityList.add("Select city");
      for(var i = 0; i < _cItyListModel.data!.length; i++){
        cityList.add(_cItyListModel.data![i].name.toString());
      }
    }
    setState(() {
      isLoad = false;
    });
  }

  Future<void> ListCountry() async {
    isLoad = true;

    _countryListModel = await Services.CountryList();
    if (_countryListModel.status == true){

      for(var i = 0; i < _countryListModel.data!.length; i++){
        countryList.add(_countryListModel.data![i].name.toString());
      }
      if(country!=""){
        ListCity(country);
      }
      // country = _userDetailModel.data?[0].country ?? "Select country";
    }
    isLoad = false;
    setState(() {
    });
  }


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
                // color: Colors,
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
                unselectedLabelColor: CommonColors.white,
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
                          child: isLoad ? Center(

                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3.0,
                            ),
                          ):new GridView.count(
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
                                        borderRadius: BorderRadius.circular(imagelist[index] == null ? 0.0:5.0 ),
                                        child: index >= 0  && index < _list.length ?
                                        Image.network(
                                          "${_list![index].image}",fit: BoxFit.cover,
                                          height: itemHeight,
                                          width: itemWidth,
                                        ) : imagelist[index] == null ? Image.asset(
                                          "assets/add_photos2.png",
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
                                    // if(_list[index] != null)
                                      index >= 0  && index < _list.length ? new Positioned(
                                      right:0,
                                      top:0,
                                      child: SizedBox(
                                        height:30,
                                        width:30,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: InkWell(onTap: () {
                                            setState((){
                                              deleteImage(_list[index].id.toString());
                                              // _list[index].image=null;
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
                                      ),):
                                      Container(),

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

                        clickLoad ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3.0,
                          ),
                        ): Container(),
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
                              new Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value:PhotoOptions,
                                  onChanged: (value){
                                    PhotoOptions = value;
                                    setState(() {});
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
                              child: Text("Get verified",style: new TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color:Colors.white),),
                            ),
                            new SizedBox(width: 10,),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/blue_tick.png",height: 20,width: 20,fit: BoxFit.cover,),
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
                            controller: about,
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
                              new Transform.scale(
                                scale: 0.8,
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
                        // Container(
                        //   height: 50,
                        //   margin: const EdgeInsets.symmetric(horizontal: 30),
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   // decoration: BoxDecoration(
                        //   //   // color: Colors.white,
                        //   //   border: Border.all(color: Colors.white),
                        //   //   borderRadius: const BorderRadius.all(Radius.circular(25)),
                        //   // ),
                        //   child: TextFormField(
                        //     keyboardType: TextInputType.name,
                        //     textInputAction: TextInputAction.done,
                        //     controller: tagsearch,
                        //     decoration: InputDecoration(
                        //         hintText: 'Add New Tag...',
                        //         border: InputBorder.none,
                        //         hintStyle: new TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 14,fontWeight: FontWeight.w400),
                        //         prefixIcon: SizedBox(child: Image.asset("assets/tag_interest.png",color: Colors.white,),),
                        //         suffixIcon: ischeck2 ? new InkWell(
                        //           onTap: (){
                        //             if(selectedIndex.length!=4){
                        //               setState((){
                        //                 tags.add(tagsearch.text!);
                        //                 selectedIndex.add(tags.length-1);
                        //               });
                        //             }else{
                        //               Toaster.show(context, "You can select only 4");
                        //             }
                        //           },
                        //           child: SizedBox(child: Icon(Icons.done,color: Colors.cyan,),),
                        //         ):null
                        //     ),
                        //     onChanged: (value){
                        //       if(value.isNotEmpty){
                        //         setState(() {
                        //           ischeck2 = true;
                        //         });
                        //       }else{
                        //         setState(() {
                        //           ischeck2 = false;
                        //         });
                        //       }
                        //     },
                        //     style: new TextStyle(color: Colors.white,fontSize: 14),
                        //     validator: (value) {
                        //       if (value!.isEmpty) {
                        //         return 'Please enter your Tag';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),

                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          // decoration: BoxDecoration(
                          //   // color: Colors.white,
                          //   border: Border.all(color: Colors.white),
                          //   borderRadius: const BorderRadius.all(Radius.circular(25)),
                          // ),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:20,width:20,
                                child: Image.asset("assets/tag_interest.png",color: Colors.white.withOpacity(0.6),height:20,width:20,),),
                              SizedBox(
                                width: 5,),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  controller: tagsearch,
                                  decoration: InputDecoration(
                                    hintText: 'Add New Tag...',
                                    border: InputBorder.none,
                                    hintStyle: new TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 14,fontWeight: FontWeight.w400),
                                    // prefixIcon: SizedBox(
                                    //   height:5,width:5,
                                    //   child: Image.asset("assets/tag_interest.png",color: Colors.white.withOpacity(0.6),height:5,width:5,),),
                                    // suffixIcon: ischeck ? new InkWell(
                                    //   onTap: (){
                                    //       if(selectedIndex.length!=4){
                                    //         setState((){
                                    //         tags.add(tagsearch.text!);
                                    //         selectedIndex.add(tags.length-1);
                                    //         });
                                    //       }else{
                                    //         Toaster.show(context, "You can select only 4");
                                    //       }
                                    //   },
                                    //   child: SizedBox(child: Icon(Icons.done,color: Colors.cyan,),),
                                    // ):null
                                  ),
                                  onChanged: (value){
                                    if(value.isNotEmpty){
                                      setState(() {
                                        ischeck2 = true;
                                      });
                                    }else{
                                      setState(() {
                                        ischeck2 = false;
                                      });
                                    }
                                  },
                                  style: new TextStyle(color: Colors.white,fontSize: 14),
                                  textAlign: TextAlign.left,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter your Tag';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,),
                              ischeck2 ? new InkWell(
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
                              ):Container()
                            ],
                          ),
                        ),

                        new SizedBox(height: 10,),
                        isLoad ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3.0,
                          ),
                        ):Container(
                          margin: const EdgeInsets.symmetric(horizontal: 27),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                prefList.length,
                                    (index){
                                  if(prefList[index] != intrest){
                                    if(selectedIndex.length!=4){
                                      selectedIndex.add(index);
                                    }
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if(selectedIndex.length!=4){
                                          selectedIndex.add(index);
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
                                            new SizedBox(width: 5,),
                                            Text("${prefList[index].title}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffDDDDDD)),),
                                            new SizedBox(width: 5,),
                                           selectedIndex.contains(index) ? new SizedBox(
                                              child: InkWell(onTap: (){
                                                setState(() {
                                                  selectedIndex.remove(index);
                                                });
                                              },child: Padding(
                                                padding: const EdgeInsets.all(0.0),
                                                child: Icon(Icons.close,color: Colors.white,),
                                              )),
                                            ): Container()
                                          ],
                                        )
                                    ),
                                  );
                                    },
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                            controller: jobTitle,
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
                            controller: company,
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
                            controller: education,
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
                              new Transform.scale(
                                scale: 0.8,
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
                              return ['Select country', 'India', 'pakistan', 'china'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: country=="Select country"? CommonColors.edittextblack : Colors.white,size: 20,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select country', 'India', 'pakistan', 'china'] // add your own dial codes
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
                              return ['Select city', 'Indore', 'bhopal', 'guna'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: city == 'Select city' ? Colors.grey : Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 24,
                            icon: Icon(Icons.arrow_forward_ios,color: city == 'Select city' ? CommonColors.edittextblack : Colors.white,size: 20,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select city', 'Indore', 'bhopal', 'guna'] // add your own dial codes
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
                              new Transform.scale(
                                scale: 0.8,
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
                                    (index){
                                      if(regions[index]!="$religion"){
                                        ischeckregion=100;
                                      }else{
                                        ischeckregion=index;
                                      }

                                  return GestureDetector(
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
                                  );
                                    },
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
                              new Transform.scale(
                                scale: 0.8,
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
                              return ['Select Caste', 'punjabi', 'gujrati', 'bangali','Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: caste== "Select Caste" ?CommonColors.edittextblack : Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios,color: caste=="Select Caste"? CommonColors.edittextblack : Colors.white,size: 20,),
                            iconDisabledColor: Colors.white,
                            items: <String>['Select Caste', 'punjabi', 'gujrati', 'bangali', 'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'] // add your own dial codes
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
                              new Transform.scale(
                                scale: 0.8,
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
                                  child: Text(value,style: TextStyle(color: tongue== "Select your mother tongue" ?CommonColors.edittextblack: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios,color:tongue== "Select your mother tongue" ? CommonColors.edittextblack : Colors.white,size: 20,),
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                              new Transform.scale(
                                scale: 0.8,
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
                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: CommonColors.buttonorg,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  clickLoad ? Expanded(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3.0,
                                        ),
                                      )
                                  ):
                                  Expanded(
                                      child: Center(
                                        child: Text("Update", style: TextStyle(
                                          color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
                                      )),
                                ],
                              ),
                              SizedBox.expand(
                                child: Material(
                                  type: MaterialType.transparency,
                                  child: InkWell(onTap: () {
                                    updateUser();
                                  },splashColor: Colors.blue.withOpacity(0.2),
                                    customBorder: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              ),
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

