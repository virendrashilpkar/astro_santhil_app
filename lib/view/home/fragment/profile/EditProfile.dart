import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shadiapp/CommonMethod/StarRating.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/CasteModel.dart';
import 'package:shadiapp/Models/ReligionModel.dart';
import 'package:shadiapp/Models/city_list_model.dart';
import 'package:shadiapp/Models/country_list_model.dart';
import 'package:shadiapp/Models/delete_image_model.dart';
import 'package:shadiapp/Models/preference_list_model.dart';
import 'package:shadiapp/Models/statelistmodel.dart';
import 'package:shadiapp/Models/upload_image_model.dart';
import 'package:shadiapp/Models/user_add_preference_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Models/user_view_preference_model.dart';
import 'package:shadiapp/Models/verifiedModel.dart';
import 'package:shadiapp/Models/view_image_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shadiapp/commonpackage/SearchChoices.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayout.dart';
import 'package:shadiapp/view/home/fragment/homesearch/customlayout/Customlayoutview.dart';
import 'package:shadiapp/view/home/fragment/profile/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:collection/collection.dart';
import 'package:flutter_sound/flutter_sound.dart';



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
  String firstName = "demo";
  String lastName = "user";
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
    // _list.clear();
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
      viewImage();
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
      // _list[index].image=null;
    }else{
      Toaster.show(context, _deleteImageModel.message.toString());
    }
    isLoad = false;
    setState(() {

    });
  }

  String zodiac_sign = "";
  String education_level = "";
  String covid_vaccine = "";
  String petss = "";
  String dietary_preference = "";
  String sleeping_habits = "";
  String social_media = "";
  String workouts = "";
  String smokings = "";
  String healths = "";
  String personality_type = "";
  String managedBy = "";
  String marriage_plan = "Within";
  String drinkings = "";
  String zodiac_signd = "";
  String education_leveld = "";
  String covid_vaccined = "";
  String petssd = "";
  String dietary_preferenced = "";
  String sleeping_habitsd = "";
  String social_mediad = "";
  String workoutsd = "";
  String smokingsd = "";
  String healthsd = "";
  String personaltyped = "";
  String drinkingsd = "";
  String personality_typed = "";
  String user_plan = "";
  double rating = 3.5;
  bool isVerified = false;
  bool isPhotoOption = false;

  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName = _userDetailModel.data![0].firstName.toString();
      lastName = _userDetailModel.data![0].lastName.toString();
      dateOfBirth = _userDetailModel.data![0].birthDate.toString();
      gender = _userDetailModel.data![0].gender.toString();
      country = _userDetailModel.data![0].country.toString();
      state = _userDetailModel.data![0].state.toString();
      if(country!=""){
        Liststate(country,state);
      }
      city = _userDetailModel.data![0].city.toString();
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
      religion = _userDetailModel.data![0].religion.toString();
      caste = _userDetailModel.data![0].caste.toString();
      if(religion!=""/* || caste!="Select Caste"*/){
        Castemethod(religion);
      }
      about.text = _userDetailModel.data![0].about.toString();
      education.text = _userDetailModel.data![0].education.toString();
      company.text = _userDetailModel.data![0].company.toString();
      jobTitle.text = _userDetailModel.data![0].jobTitle.toString();
      zodiac_sign = _userDetailModel.data![0].zodiacSign.toString();
      covid_vaccine = _userDetailModel.data![0].covidVaccine.toString();
      petss = _userDetailModel.data![0].pets.toString();
      dietary_preference = _userDetailModel.data![0].dietaryPreference.toString();
      education_level = _userDetailModel.data![0].educationLevel.toString();
      sleeping_habits = _userDetailModel.data![0].sleepingHabits.toString();
      social_media = _userDetailModel.data![0].socialMedia.toString();
      workouts = _userDetailModel.data![0].workout.toString();
      healths = _userDetailModel.data![0].health.toString();
      smokings = _userDetailModel.data![0].smoking.toString();
      drinkings = _userDetailModel.data![0].drinking.toString();
      personality_type = _userDetailModel.data![0].personalityType.toString();
      marriage_plan = _userDetailModel.data![0].marriagePlan.toString();
      mother_tongue = _userDetailModel.data![0].motherTongue.toString();
      managedBy = _userDetailModel.data![0].managedBy.toString();
      user_plan = _userDetailModel.data![0].plan.toString();
      is_age = _userDetailModel.data![0].isAge ?? false;
      is_height = _userDetailModel.data![0].isHeight ?? false;
      is_weight = _userDetailModel.data![0].isWeight ?? false;
      is_smoke = _userDetailModel.data![0].isSmoke ?? false;
      is_drink = _userDetailModel.data![0].isDrink ?? false;
      is_diet = _userDetailModel.data![0].isDiet ?? false;
      isVerified = _userDetailModel.data![0].isVerified ?? false;
      isPhotoOption = _userDetailModel.data![0].isPhotoOption ?? false;
      setState(() {

      });
    }
  }

  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _updateUserModel = await Services.UpdateUser2(
        {
          "userId": "${_preferences?.getString(ShadiApp.userId)}",
          if(firstName!="null") "first_name": firstName,
          if(lastName!="null")  "last_name": lastName,
          if(dateOfBirth!="null")  "birth_date": dateOfBirth,
          if(gender!="null")  "gender": gender,
          if(country!="null")  "country": country,
          if(city!="null")  "city": city,
          if(state!="null")  "state": state,
          if(height!="null")  "height": height,
          if(weight!="null")  "weight": weight,
          if(maritalStatus!="null")  "marital_status": maritalStatus,
          if(email!="null")  "email": email,
          if(lookingFor!="null")  "looking_for": lookingFor,
          if(religion!="null")  "religion": religion,
          if(caste!="null")  "caste": caste,
          if(about.text!="null")  "about": about.text,
          if(education.text!="null")  "education": education.text,
          if(jobTitle.text!="null")  "job_title": jobTitle.text,
          if(company.text!="null")  "company": company.text,
          if(zodiac_signd!="null")  "zodiac_sign":zodiac_signd,
          if(education_leveld!="null")  "education_level":education_leveld,
          if(covid_vaccined!="null")  "covid_vaccine":covid_vaccined,
          if(petssd!="null")  "pets":petssd,
          if(dietary_preferenced!="null")  "dietary_preference":dietary_preferenced,
          if(sleeping_habitsd!="null")  "sleeping_habits":sleeping_habitsd,
          if(social_mediad!="null")  "social_media":social_mediad,
          if(workoutsd!="null")  "workout":workoutsd,
          if(smokingsd!="null")  "smoking":smokingsd,
          if(healthsd!="null")  "health":healthsd,
          if(drinkingsd!="null")  "drinking":drinkingsd,
          if(personality_typed!="null")  "personality_type":personality_typed,
          if(marriage_plan!="null")  "marriage_plan":marriage_plan,
          if(mother_tongue!="null")  "mother_tongue":mother_tongue,
          if(managedBy!="null")  "managedBy":managedBy,
          "is_age":is_age.toString(),
          "is_height":is_height.toString(),
          "is_weight":is_weight.toString(),
          "is_smoke":is_smoke.toString(),
          "is_drink":is_drink.toString(),
          "is_diet":is_diet.toString(),
          "is_photo_option":isPhotoOption.toString(),
        }

        // "${_preferences?.getString(ShadiApp.userId)}",
        // firstName, lastName, dateOfBirth, gender, country, city,state ,height, weight,
        // maritalStatus, email, lookingFor, religion, caste, about.text, education.text,
        // company.text, jobTitle.text, zodiac_signd, education_leveld, covid_vaccined,
        // petssd, dietary_preferenced, sleeping_habitsd, social_mediad, workoutsd,
        // smokingsd, healthsd, drinkingsd, personality_typed, marriage_plan, mother_tongue, managedBy
    );
    if(_updateUserModel.status == 1){
      if(mounted) {
        Toaster.show(context, _updateUserModel.message.toString());
      }
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
  Future<void> Verifyuser() async {

    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      _preferences = await SharedPreferences.getInstance();
      VerifiedModel verified = await Services.VerifyMethod("${_preferences?.getString(ShadiApp.userId).toString()}",File(pickedFile.path));
      if(verified.status == 1){
        Toaster.show(context, verified.message.toString());
        isVerified=verified.data?.isVerified ?? false;
      }
      setState((){
      //   imagelist[index] = File(pickedFile.path);
      //   uploadImage(File(pickedFile.path));
      });
    }

    // isLoad = true;
    // _preferences = await SharedPreferences.getInstance();
    // VerifiedModel verified = await Services.VerifyMethod("${_preferences?.getString(ShadiApp.userId).toString()}");
    // if(verified.status == 1){
    //   Toaster.show(context, verified.message.toString());
    //   isVerified=verified.data?.isVerified ?? false;
    // }
    // isLoad = false;
    // setState(() {
    //
    // });
  }

  // Future<void> userViewPreference() async {
  //   _preferences = await SharedPreferences.getInstance();
  //   _viewPreferenceModel = await Services.ViewUserPreference(_preferences.getString(ShadiApp.userId).toString());
  //   if(_viewPreferenceModel.status == 1){
  //     for (int i = 0; i < _viewPreferenceModel.data!.length; i++){
  //       intrest = _viewPreferenceModel.data ?? <PrefsDatum> [];
  //     }
  //     intrest.forEach((element) {
  //       if (prefList.contains(element)){
  //         print("ahsdjfsdhfjshfs ${element.preference}");
  //       }
  //     });
  //   }
  //   setState(() {
  //
  //   });
  // }

  List<File?> imagelist = List.filled(6, null);
  // List<File?> imagelist=[null,null,null,null,null,null];
 late TabController _tabController;

  List<DropdownMenuItem> countryitems = [];
  List<DropdownMenuItem> stateitems = [];
  List<DropdownMenuItem> cityitems = [];

  String country = 'Select country';
  String state = 'Select state';
  String city = 'Select city';

  late CountryListModel _countryListModel;
  late StateListModel _stateListModel;
  late CItyListModel _cItyListModel;
  Future<void> ListCountry() async {
    isLoad = true;

    _countryListModel = await Services.CountryList();
    if (_countryListModel.status == true){

      for(var i = 0; i < _countryListModel.data!.length; i++){
        countryList.add(_countryListModel.data![i].name.toString());
        countryitems.add(DropdownMenuItem(
          value: _countryListModel.data![i].name.toString(),
          child: Text(_countryListModel.data![i].name.toString()),
        ));
      }
      // if(country!=""){
      //   ListCity(country);
      // }
      // country = _userDetailModel.data?[0].country ?? "Select country";
    }
    isLoad = false;
    setState(() {
    });
  }
  Future<void> Liststate(name,state) async {
    isLoad = true;
    stateitems.clear();
    stateList.clear();
    _stateListModel = await Services.StateList(name,"");
    if (_stateListModel.status == true){
      for(var i = 0; i < _stateListModel.data!.length; i++){
        stateList.add(_stateListModel.data![i].name.toString());
        stateitems.add(DropdownMenuItem(
          value: _stateListModel.data![i].name.toString(),
          child: Text(_stateListModel.data![i].name.toString()),
        ));
      }
    }
    if(state!=""){
      city = _userDetailModel.data![0].city.toString();
      ListCity(state,city);
    }
    isLoad = false;
    setState(() {
    });
  }

  Future<void> ListCity(String name,cityname) async {
    print("LISTCITY>>>>$name");
    setState(() {
      isLoad = true;
    });
    cityList.clear();
    cityitems.clear();
    List<Statedata> stateDataList=[];
    List<CountryData> countryDataList=[];
    // try{

       stateDataList = _stateListModel.data!.where((user) {
        return user.name == state;
      }).toList();
    countryDataList = _countryListModel.data!.where((user) {
      return user.name == country;
    }).toList();
    // }catch(error){
    // }

    _cItyListModel = await Services.CityList("",stateDataList.isNotEmpty ? "${stateDataList[0]?.isoCode}":"",countryDataList.isNotEmpty ? "${countryDataList[0]?.countryCode}":"");
    if(_cItyListModel.status == true){
      cityList.add("Select city");
      for(var i = 0; i < _cItyListModel.data!.length; i++){
        cityList.add(_cItyListModel.data![i].name.toString());
        cityitems.add(DropdownMenuItem(
          value: _cItyListModel.data![i].name.toString(),
          child: Text(_cItyListModel.data![i].name.toString()),
        ));
      }
    }
    print(">>>$cityname");
    setState(() {
      if(cityname!="") {
        city = cityname;
      }
      isLoad = false;
    });

  }



  String religions = 'Select religion';
  // String cast = 'Select cast';
  List<String> religionList=[];
  List<String> castList=[];
  void Religionmethod() async{
    ReligionModel religionModel = await Services.ReligionMethod();
    if(religionModel.data?.isNotEmpty ?? false){
      // religionList.add("Select religion");
      for(ReligionDatum item in religionModel.data ?? []){
        religionList.add(item.name ?? "");
      }
    }
    setState(() {
    });
  }
  void Castemethod(String name) async{
    castList.clear();
    CasteModel casteModel = await Services.CasteMethod(name);
    if(casteModel.data?.isNotEmpty ?? false){
      castList.add("Select Caste");
      for(CasteDatum item in casteModel.data ?? []){
        castList.add(item.caste ?? "");
      }
    }
    setState(() {
    });
  }


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
    Religionmethod();
    viewPrefs();
    // userViewPreference();
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
  bool Interests=true;
  bool managedby=true;
  bool basicinfo=true;
  bool Lifestyle=true;
  bool Living=true;
  bool diet=true;
  bool drink=true;
  bool smoke=true;
  bool weightb=true;
  bool heightb=true;
  bool age=true;
  bool mothertongue=true;
  bool casteb=true;
  bool Religion=true;
  int ischeck=100;
  int ischeckregion=100;
  bool ischeck2 =false;
  bool is_age =false;
  bool is_height =false;
  bool is_weight =false;
  bool is_smoke =false;
  bool is_drink =false;
  bool is_diet =false;

  List<String> cityList = [
    "Select city"
  ];
  List<String> countryList = [
    "Select country"
  ];
  List<String> stateList = [
    "Select state"
  ];


  late AddPreferenceModel _addPreferenceModel;
  Future<void> addPrefs(String preferenceId) async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _addPreferenceModel = await Services.AddPrefsMethod(
        "${_preferences?.getString(ShadiApp.userId)}", preferenceId);
    // if (_addPreferenceModel.status == 1) {
    //   Toaster.show(context, _addPreferenceModel.message.toString());
    // } else {
    //   Toaster.show(context, _addPreferenceModel.message.toString());
    // }
    setState(() {
      clickLoad = false;
    });
  }
  Future<void> addCustomPrefs(String title) async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    _addPreferenceModel = await Services.AddCustomPrefsMethod(
        "${_preferences?.getString(ShadiApp.userId)}", title);
    tagsearch.text="";
    ischeck2 = false;
    viewPrefs();
    // if(_addPreferenceModel.status == 1){
    //   Toaster.show(context, _addPreferenceModel.message.toString());
    // }else{
    //   Toaster.show(context, _addPreferenceModel.message.toString());
    // }
    setState(() {
      clickLoad = false;
    });
  }

  String caste = 'Select Caste';
  String mother_tongue = 'Select your mother tongue';


  // String zodiac="Add",eduction="Add",covid="Add",health="Add",personaltype="Add";
  // String pets="Add",drinking="Add",smoking="Add",working="Add",workout="Add",dietary="Add",socialmedia="Add",sleeping="Add";


  FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  FlutterSoundPlayer _soundPlayer = FlutterSoundPlayer();
  bool _playAudio = false;

  void startRecording() async {
    try {
      await _soundRecorder.startRecorder(toFile: 'path_to_save_file', codec: Codec.aacMP4);
    } catch (e) {
      // Handle any errors
    }
  }

  void stopRecording() async {
    try {
      String? path = await _soundRecorder.stopRecorder();
      playAudio(path!);
      // Upload the recorded file to the API
    } catch (e) {
      // Handle any errors
    }
  }

  void playAudio(String filePath) async {
    try {
      await _soundPlayer.startPlayer(fromURI: filePath);
    } catch (e) {
      // Handle any errors
    }
  }

  void stopAudio() async {
    try {
      await _soundPlayer.stopPlayer();
    } catch (e) {
      // Handle any errors
    }
  }



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
                                  border:Border.all(color: Colors.white),
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
                                        child: _viewImageModel.status == 1 ?
                                        Container(
                                          child: index >= 0  && index < _list.length ?Image.network(
                                            "${_list![index].image}",fit: BoxFit.cover,
                                            height: itemHeight,
                                            width: itemWidth,
                                          ):Image.asset(
                                            "assets/add_photos.png",
                                            fit: BoxFit.cover,
                                            // height: itemHeight,
                                          ),
                                        )     // width: itemWidth,
                                            :imagelist[index] == null ? Image.asset(
                                          "assets/add_photos.png",
                                          fit: BoxFit.cover,
                                          // height: itemHeight,
                                          // width: itemWidth,
                                        ):Image.file(imagelist[index]!,fit: BoxFit.cover,
                                          height: itemHeight,
                                          width: itemWidth,)
                                    ),

                                    // ClipRRect(
                                    //     borderRadius: BorderRadius.circular(imagelist[index] == null ? 0.0:5.0 ),
                                    //     child: index >= 0  && index < _list.length ?
                                    //     Image.network(
                                    //       "${_list![index].image}",fit: BoxFit.cover,
                                    //       height: itemHeight,
                                    //       width: itemWidth,
                                    //     ) : imagelist[index] == null ? Image.asset(
                                    //       "assets/add_photos2.png",
                                    //       fit: BoxFit.cover,
                                    //       // height: itemHeight,
                                    //       // width: itemWidth,
                                    //     ):Image.file(imagelist[index]!,fit: BoxFit.cover,
                                    //       height: itemHeight,
                                    //       width: itemWidth,)
                                    // ),
                                    SizedBox.expand(
                                      child: Material(
                                        type: MaterialType.transparency,
                                        child: InkWell(onTap: () {
                                          if(index >= 0  && index < _list.length){

                                          }else{
                                            _pickedImage(index);
                                          }
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
                                            // child:  Container(
                                            //     decoration: BoxDecoration(
                                            //       // color: Colors.white,
                                            //       borderRadius: const BorderRadius.all(Radius.circular(15)),
                                            //     ),
                                            //     child: Icon(Icons.close,color: Colors.white,)),
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
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                                  value:isPhotoOption,
                                  onChanged: (value){
                                    isPhotoOption = value;
                                    setState(() {});
                                  },
                                  thumbColor: isPhotoOption ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        if(isPhotoOption) new SizedBox(height: 10,),
                        if(isPhotoOption) Container(
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
                        if(isPhotoOption) new SizedBox(height: 10,),
                        if(isPhotoOption) Container(
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
                            if(isVerified) SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset("assets/blue_tick.png",height: 20,width: 20,fit: BoxFit.cover,),
                            )
                          ],
                        ),
                        new SizedBox(height: 15,),
                        InkWell(
                          onTap:(){
                            // if(isVerified){
                            //   Toaster.show(context, "Already Verified");
                            // }else {
                              Verifyuser();
                            // }
                          },
                          child: Container(
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
                                  child: new Text(isVerified ? "Request sented":"Take a selfie",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.editblackgrey),),
                                ),
                                new Spacer(),
                                new Container(
                                    child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                                ),
                                // new SizedBox(width: 20,),
                              ],
                            ),
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
                            maxLines: 11,
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
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                                  value:Interests,
                                  onChanged: (value){
                                    Interests = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: Interests ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        // intrests
                        if(Interests) new Column(
                          children: [
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
                              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                                      addCustomPrefs(tagsearch.text!);
                                      // if(selectedIndex.length!=4){
                                      //   setState((){
                                      //     tags.add(tagsearch.text!);
                                      //     selectedIndex.add(tags.length-1);
                                      //   });
                                      // }else{
                                      //   Toaster.show(context, "You can select only 4");
                                      // }
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
                              margin: const EdgeInsets.symmetric(horizontal: 25),
                              alignment: Alignment.centerLeft,
                              child: Wrap(
                                children: [
                                  ...List.generate(
                                    prefList.length, (index){
                                    // if(prefList[index].isActive ?? false){
                                    //   if(selectedIndex.length!=3){
                                    //     selectedIndex.add(index);
                                    //   }
                                    // }
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          addPrefs(prefList![index].id.toString());
                                          if (prefList[index].is_select==true) {
                                            prefList[index].is_select=false;
                                          }else{
                                            prefList[index].is_select=true;
                                          }
                                        });
                                        // setState(() {
                                        //   if (selectedIndex.length != 4) {
                                        //     selectedIndex.add(index);
                                        //     addPrefs(prefList![index].id.toString());
                                        //   }else{
                                        //     Toaster.show(
                                        //         context, "You can select only 4");
                                        //   }
                                        // });
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.white),
                                            color: prefList[index].is_select ?? false ? CommonColors.buttonorg : null,
                                            borderRadius: BorderRadius.circular(65),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              new SizedBox(width: 5,),
                                              Text("${prefList[index].title}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xffDDDDDD)),),
                                              new SizedBox(width: 5,),
                                              prefList[index].is_select ?? false ? new SizedBox(
                                                child: InkWell(onTap: (){
                                                  setState(() {
                                                    addPrefs(prefList![index].id.toString());
                                                    if (prefList[index].is_select==true) {
                                                      prefList[index].is_select=false;
                                                    }else{
                                                      prefList[index].is_select=true;
                                                    }
                                                  });
                                                  // setState(() {
                                                  //   selectedIndex.remove(index);
                                                  // });
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
                                  ),
                                ],
                              ),
                            ),
                            new SizedBox(height: 20,),
                          ],
                        ),




                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                                  value:managedby,
                                  onChanged: (value){
                                    managedby = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: managedby ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                       if(managedby) Column(
                         children: [
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

                                        managedBy=="Self" ? InkWell(
                                          onTap: (){
                                            setState(() {
                                              ischeck=100;

                                              managedBy="";
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
                                              managedBy="Self";
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

                                        managedBy=="Sibling" ? InkWell(
                                          onTap: (){
                                            setState(() {
                                              ischeck=100;
                                              managedBy="";
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
                                              managedBy="Sibling";
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
                                        managedBy=="Parents"? InkWell(
                                          onTap: (){
                                            setState(() {
                                              ischeck=100;
                                              managedBy="";
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
                                              managedBy="Parents";
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
                           new SizedBox(height: 15,)
                         ],
                       ),
                        new Container(
                          margin: const EdgeInsets.only(left: 30,right: 30),
                          alignment: Alignment.centerLeft,
                          child: new Text("Marriage plan",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        ),
                        new SizedBox(height: 15,),

                        Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: CommonColors.editblack,
                            // border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                          ),
                          child: DropdownButton<String>(
                            value: marriage_plan=="null" || marriage_plan==""?"Within":marriage_plan,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                marriage_plan = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ["Within","Six Months","One Year"].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: marriage_plan== "Within" ?CommonColors.edittextblack : Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios,color: marriage_plan=="Within"? CommonColors.edittextblack : Colors.white,size: 20,),
                            iconDisabledColor: Colors.white,
                            items: ["Within","Six Months","One Year"] // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),
                        // Container(
                        //   height:50,
                        //   margin: const EdgeInsets.only(left: 30,right: 30),
                        //   decoration: BoxDecoration(
                        //       color: CommonColors.editblack,
                        //       borderRadius: BorderRadius.circular(37)
                        //   ),
                        //   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        //   child: Row(
                        //     children: [
                        //       // new SizedBox(width: 20,),
                        //       new Container(
                        //           child: Image.asset("assets/within.png")
                        //       ),
                        //       new SizedBox(width: 5,),
                        //       new Container(
                        //         height: 30,
                        //         child: DropdownButton<String>(
                        //           value: marriage_plan,
                        //           underline: Container(
                        //             // height: 1,
                        //             // margin:const EdgeInsets.only(top: 20),
                        //             // color: Colors.white,
                        //           ),
                        //           isExpanded: true,
                        //           style: TextStyle(color: Colors.white,fontSize: 16),
                        //           onChanged: (newValue) {
                        //             setState(() {
                        //               marriage_plan = newValue!;
                        //             });
                        //           },
                        //           selectedItemBuilder: (BuildContext context) {
                        //             return ["Within","Six Months","One Year"].map((String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Text(value,style: TextStyle(color: marriage_plan== "Within" ?CommonColors.edittextblack : Colors.white,fontSize: 16),),
                        //               );
                        //             }).toList();
                        //           },
                        //           iconSize: 20,
                        //           icon: Icon(Icons.arrow_forward_ios,color: marriage_plan=="Within"? CommonColors.edittextblack : Colors.white,size: 20,),
                        //           iconDisabledColor: Colors.white,
                        //           items: <String>["Within","Six Months","One Year"] // add your own dial codes
                        //               .map<DropdownMenuItem<String>>((String value) {
                        //             return DropdownMenuItem<String>(
                        //               value: value,
                        //               child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                        //             );
                        //           }).toList(),
                        //         ),
                        //       ),
                        //       // new Container(
                        //       //     child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                        //       // ),
                        //       // new SizedBox(width: 20,),
                        //     ],
                        //   ),
                        // ),
                        new SizedBox(height: 50,),


                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Row(
                            children: [
                              // new SizedBox(width: 20,),
                              new Container(
                                child: new Text("Basic info",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                              ),
                              Spacer(),
                              new Transform.scale(
                                scale: 0.8,
                                child: CupertinoSwitch(
                                  value:basicinfo,
                                  onChanged: (value){
                                    basicinfo = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: basicinfo ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30),
                        //   alignment: Alignment.centerLeft,
                        //   child: Text("Basic info",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                        // ),
                        // InkWell(onTap:(){openDialog(context,"eduction");},child:Customlayout(icon: 'assets/education_bottom.png',tittle: 'Education',status: '$eduction',),),
                        // InkWell(onTap:(){openDialog(context,"covid");},child:Customlayout(icon: 'assets/covid_bottom.png',tittle: 'COVID vaccine',status: '$covid',),),
                        // InkWell(onTap:(){openDialog(context,"health");},child:Customlayout(icon: 'assets/health_bottom.png',tittle: 'Health',status: '$health',),),
                        // InkWell(onTap:(){openDialog(context,"personaltype");},child:Customlayout(icon: 'assets/persional_bottom.png',tittle: 'Personality type',status: '$personaltype',),),

                       if(basicinfo) Column(
                          children: [
                            new SizedBox(height: 20,),
                            Customlayout(icon: 'assets/zodiac_icon.png',title: 'Zodiac',selectedItem:"$zodiac_sign",dropdownItems: "645a24f6c46146c70ceef85e",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  zodiac_sign=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  zodiac_signd=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/education_bottom.png',title: 'Education',selectedItem:"$education_level",dropdownItems: "644f86833153f40588bbd101",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  education_level=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  education_leveld=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/covid_bottom.png',title: 'COVID vaccine',selectedItem:"$covid_vaccine",dropdownItems: "644fa1dbbf73df1a4d885a56",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  covid_vaccine=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  covid_vaccined=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/health_bottom.png',title: 'Health',selectedItem:"$healths",dropdownItems: "64afe579de520a14346455bc",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  healths=selectedItem;
                                });
                              }, onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  healthsd=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/persional_bottom.png',title: 'Personality type',selectedItem:"$personality_type",dropdownItems: "64affcb625a4f99a26baf001",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  personality_type=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  personality_typed=selectedItem;
                                });
                              },),
                            new SizedBox(height: 40,),
                          ],
                        ),


                        Container(
                          margin: const EdgeInsets.only(left: 20,right: 20),
                          // decoration: BoxDecoration(
                          //     color: CommonColors.editblack,
                          //     borderRadius: BorderRadius.circular(37)
                          // ),
                          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
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
                                  value:Lifestyle,
                                  onChanged: (value){
                                    Lifestyle = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: Lifestyle ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 30),
                        //   child: Row(
                        //     children: [
                        //       // new SizedBox(width: 20,),
                        //       new Container(
                        //         child: new Text("Lifestyle",style: new TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: CommonColors.white),),
                        //       ),
                        //       Spacer(),
                        //       new Transform.scale(
                        //         scale: 0.8,
                        //         child: CupertinoSwitch(
                        //           value:Lifestyle,
                        //           onChanged: (value){
                        //             Lifestyle = value;
                        //             setState(() {
                        //             });
                        //           },
                        //           thumbColor: Lifestyle ? CommonColors.buttonorg:CupertinoColors.black,
                        //           activeColor: CupertinoColors.white,
                        //           trackColor: CupertinoColors.white,
                        //         ),
                        //       ),
                        //       // new SizedBox(width: 20,),
                        //     ],
                        //   ),
                        // ),
                       if(Lifestyle) Column(
                          children: [
                            SizedBox(height: 20,),
                            Customlayout(icon: 'assets/pet_icon.png',title: 'Pets',selectedItem:"$petss",dropdownItems: "644f87093153f40588bbd111",
                              onDropdownChanged: (selectedItem) {
                                setState(() {
                                  petss=selectedItem;
                                });
                                // Handle the selected item
                              },onDropdownChanged2: (selectedItem) {
                                setState(() {
                                  petssd=selectedItem;
                                });
                                // Handle the selected item
                              },),
                            Customlayout(icon: 'assets/drink_bottom.png',title: 'Drinking',selectedItem:"$drinkings",dropdownItems: "644f9c91bf73df1a4d885a20",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  drinkings=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  drinkingsd=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/smoke_bottom.png',title: 'Smoking',selectedItem:"$smokings",dropdownItems: "644f9d6cbf73df1a4d885a2e",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  smokings=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  smokingsd=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/workout_bottom.png',title: 'Workout',selectedItem:"$workouts",dropdownItems: "644fa0bebf73df1a4d885a3a",
                              onDropdownChanged: (selectedItem) {
                                setState(() {
                                  workouts=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                setState(() {
                                  workoutsd=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/dientary_bottom.png',title: 'Dietary preference',selectedItem:"$dietary_preference",dropdownItems: "644fa116bf73df1a4d885a44",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  dietary_preference=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  dietary_preferenced=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/social_bottom.png',title: 'Social media',selectedItem:"$social_media",dropdownItems: "64affcd725a4f99a26baf005",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  social_media=selectedItem;
                                });
                              },onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  social_mediad=selectedItem;
                                });
                              },),
                            Customlayout(icon: 'assets/sleep_bottom.png',title: 'Sleeping habits',selectedItem:"$sleeping_habits",dropdownItems: "6452a9626abdec919eed862c",
                              onDropdownChanged: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  sleeping_habits=selectedItem;
                                });
                              }, onDropdownChanged2: (selectedItem) {
                                // Handle the selected item
                                setState(() {
                                  sleeping_habitsd=selectedItem;
                                });
                              },),
                            new SizedBox(height: 20,),
                          ],
                        ),


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
                                  value:Living,
                                  onChanged: (value){
                                    Living = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: Living ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                        if(Living) Column(
                          children: [
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
                              child:
                              SearchChoices.single(
                                items: countryitems,
                                value: country,
                                hint: "Select country",
                                disabledHint: "Disabled",
                                searchHint: "Select country",
                                style: TextStyle(color: Colors.white),
                                underline: Container(),
                                onChanged: (value) {
                                  setState(() {
                                    country = value;
                                    city = "Select city";
                                    cityList.clear();
                                    cityList.add("Select city");
                                    state = 'Select state';
                                    city = 'Select city';
                                    Liststate(country,"");
                                  });
                                },
                                displayClearIcon: false,
                                isExpanded: true,
                              ),
                              // DropdownButton<String>(
                              //   value: country,
                              //   underline: Container(
                              //     // height: 1,
                              //     // margin:const EdgeInsets.only(top: 20),
                              //     // color: Colors.white,
                              //   ),
                              //   isExpanded: true,
                              //   style: TextStyle(color: Colors.white,fontSize: 16),
                              //   onChanged: (newValue) {
                              //     setState(() {
                              //       country = newValue!;
                              //     });
                              //   },
                              //   selectedItemBuilder: (BuildContext context) {
                              //     return ['Select country', 'India', 'pakistan', 'china'].map((String value) {
                              //       return DropdownMenuItem<String>(
                              //         value: value,
                              //         child: Text(value,style: TextStyle(color: Colors.white,fontSize: 16),),
                              //       );
                              //     }).toList();
                              //   },
                              //   iconSize: 24,
                              //   icon: Icon(Icons.arrow_forward_ios,color: country=="Select country"? CommonColors.edittextblack : Colors.white,size: 20,),
                              //   iconDisabledColor: Colors.white,
                              //   items: <String>['Select country', 'India', 'pakistan', 'china'] // add your own dial codes
                              //       .map<DropdownMenuItem<String>>((String value) {
                              //     return DropdownMenuItem<String>(
                              //       value: value,
                              //       child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              //     );
                              //   }).toList(),
                              // ),
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
                              child:
                              SearchChoices.single(
                                items: stateitems,
                                value: state,
                                hint: "Select State",
                                searchHint: "Select State",
                                style: TextStyle(color: Colors.white),
                                underline: Container(),
                                onChanged: (value) {
                                  setState(() {
                                    state = value;
                                    city="Select city";
                                    ListCity(state,"");
                                  });
                                },
                                displayClearIcon: false,
                                isExpanded: true,
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
                              child: SearchChoices.single(
                                items: cityitems,
                                value: city,
                                hint: "Select city",
                                searchHint: "Select city",
                                style: TextStyle(color: Colors.white),
                                underline: Container(),
                                onChanged: (value) {
                                  setState(() {
                                    city = value;
                                  });
                                },
                                displayClearIcon: false,
                                isExpanded: true,
                              ),
                            ),
                          ],
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
                                  value:Religion,
                                  onChanged: (value){
                                    Religion = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: Religion ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),

                        if(Religion) new SizedBox(height: 10,),
                        if(Religion) Container(
                          margin: const EdgeInsets.symmetric(horizontal: 27),
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            children: [
                              ...List.generate(
                                religionList.length,
                                    (index){
                                      if(religionList[index]!="$religion"){
                                        ischeckregion=100;
                                      }else{
                                        ischeckregion=index;
                                      }

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if(ischeckregion==index){
                                          ischeckregion=100;
                                        }else{
                                          ischeckregion=index;
                                          religion=religionList[index];
                                          caste="Select Caste";
                                          Castemethod(religion);
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
                                              child: new Text("${religionList[index]}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.edittextblack),),
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
                                  value:casteb,
                                  onChanged: (value){
                                    casteb = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: casteb ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                       if(casteb) Container(
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
                              return castList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: caste== "Select Caste" ?CommonColors.edittextblack : Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios,color: caste=="Select Caste"? CommonColors.edittextblack : Colors.white,size: 20,),
                            iconDisabledColor: Colors.white,
                            items: castList // add your own dial codes
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: CommonColors.themeblack,fontSize: 16),),
                              );
                            }).toList(),
                          ),
                        ),
                        if(casteb) new Container(
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
                                  value:mothertongue,
                                  onChanged: (value){
                                    mothertongue = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: mothertongue ? CommonColors.buttonorg:CupertinoColors.black,
                                  activeColor: CupertinoColors.white,
                                  trackColor: CupertinoColors.white,
                                ),
                              ),
                              // new SizedBox(width: 20,),
                            ],
                          ),
                        ),


                       if(mothertongue) Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          // decoration: BoxDecoration(
                          //   color: CommonColors.editblack,
                          //   // border: Border.all(color: Colors.white),
                          //   borderRadius: const BorderRadius.all(Radius.circular(25)),
                          // ),
                          child: DropdownButton<String>(
                            value: mother_tongue=="null" ? "Select your mother tongue":mother_tongue,
                            underline: Container(
                              // height: 1,
                              // margin:const EdgeInsets.only(top: 20),
                              // color: Colors.white,
                            ),
                            isExpanded: true,
                            style: TextStyle(color: Colors.white,fontSize: 16),
                            onChanged: (newValue) {
                              setState(() {
                                mother_tongue = newValue!;
                              });
                            },
                            selectedItemBuilder: (BuildContext context) {
                              return ['Select your mother tongue', 'Hindi', 'English'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(color: mother_tongue== "Select your mother tongue" ?CommonColors.edittextblack: Colors.white,fontSize: 16),),
                                );
                              }).toList();
                            },
                            iconSize: 20,
                            icon: Icon(Icons.arrow_forward_ios,color:mother_tongue== "Select your mother tongue" ? CommonColors.edittextblack : Colors.white,size: 20,),
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
                                  value:is_age,
                                  onChanged: (value){
                                    is_age = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_age ? CommonColors.buttonorg:CupertinoColors.black,
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
                                  value:is_height,
                                  onChanged: (value){
                                    is_height = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_height ? CommonColors.buttonorg:CupertinoColors.black,
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
                                  value:is_weight,
                                  onChanged: (value){
                                    is_weight = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_weight ? CommonColors.buttonorg:CupertinoColors.black,
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
                                  value:is_smoke,
                                  onChanged: (value){
                                    is_smoke = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_smoke ? CommonColors.buttonorg:CupertinoColors.black,
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
                                  value:is_drink,
                                  onChanged: (value){
                                    is_drink = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_drink ? CommonColors.buttonorg:CupertinoColors.black,
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
                                  value:is_diet,
                                  onChanged: (value){
                                    is_diet = value;
                                    setState(() {
                                    });
                                  },
                                  thumbColor: is_diet ? CommonColors.buttonorg:CupertinoColors.black,
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
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                _playAudio = !_playAudio;
                              });
                              if (_playAudio) startRecording();
                              if (!_playAudio) stopRecording();
                            },
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
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //   height: MediaQuery.of(context).padding.top+60,
                                // ),
                                Stack(
                                  children: [
                                    Container(
                                        child:  ClipRRect(
                                          borderRadius: BorderRadius.circular(15.0),
                                          child: Image.network(_list.isNotEmpty ? "${_list[0].image}":"",fit: BoxFit.cover,height: 400,width: MediaQuery.of(context).size.width,),
                                        )
                                    ),
                                    // Container(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: InkWell(
                                    //     onTap: (){
                                    //       Navigator.pop(context);
                                    //     },
                                    //     child: Icon(
                                    //       Icons.arrow_back_ios,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                new SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      // margin: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "${firstName[0].toUpperCase()+firstName.substring(1)} ${lastName[0].toUpperCase()+lastName.substring(1)} ${age}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    new SizedBox(width: 15,),
                                    if(isVerified) SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image.asset("assets/blue_tick.png",height: 25,width: 25,),
                                    )
                                  ],
                                ),
                                new SizedBox(height: 11,),
                                Container(
                                  alignment: Alignment.topLeft,
                                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "${city},${state},${country} \n"
                                        " ${height.replaceAll(".", "`")},"
                                        " ${weight}kg,"
                                        " ${religion},"
                                        " ${maritalStatus}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),

                                new SizedBox(height: 14,),
                                Row(
                                  children: [
                                    Container(
                                      height:26,
                                      decoration: BoxDecoration(
                                        color:CommonColors.yellow,
                                        border: Border.all(
                                            width: 1.0
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0) //                 <--- border radius here
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                      alignment: Alignment.center,
                                      child: Text("$user_plan",style: new TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                                        child: StarRating(
                                          color: CommonColors.yellow,
                                          rating: rating,
                                          size:26,
                                          onRatingChanged: (rating) => setState(() => rating = rating),
                                        )
                                    )
                                  ],
                                ),
                                new SizedBox(height: 11,),

                                Row(
                                  children: [
                                    Container(
                                      height:23,
                                      // width: 120,
                                      decoration: BoxDecoration(
                                        color:CommonColors.buttonorg,
                                        border: Border.all(
                                            width: 1.0
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(32.0) //                 <--- border radius here
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                                      alignment: Alignment.centerLeft,
                                      child: Text("$marriage_plan",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                                new SizedBox(height: 40,),
                                new Container(height: 1,width: double.infinity,color: Colors.white,),
                                if(about.text!="null") new SizedBox(height: 40,),
                                if(about.text!="null") Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("ABOUT ME",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                                ),
                                if(about.text!="null") new SizedBox(height: 10,),
                                if(about.text!="null") Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${about.text}",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 16),textAlign: TextAlign.start,),
                                ),
                                // new SizedBox(height: 10,),
                                // Container(
                                //   alignment: Alignment.centerLeft,
                                //   child: Wrap(
                                //     children: [
                                //       ...List.generate(
                                //         about.length,
                                //             (index) => GestureDetector(
                                //           child: Container(
                                //               margin: const EdgeInsets.only(right: 5,top:5),
                                //               decoration: BoxDecoration(
                                //                 color: CommonColors.buttonorg,
                                //                 borderRadius: BorderRadius.circular(65),
                                //               ),
                                //               padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                //               child: Row(
                                //                 mainAxisSize: MainAxisSize.min,
                                //                 children: [
                                //                   Text("${about[index]}",style: new TextStyle(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.white),),
                                //                 ],
                                //               )
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                                if(prefList.isNotEmpty)  new SizedBox(height: 40,),
                                if(prefList.isNotEmpty)  Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("My Interests",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                                ),
                                if(prefList.isNotEmpty) SizedBox(height: 20,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Wrap(
                                    children: [
                                      ...List.generate(
                                        prefList.length,
                                            (index) => prefList[index].is_select ?? false ? GestureDetector(
                                          child: Container(
                                              margin: const EdgeInsets.only(right: 5,top:5),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.white),
                                                // color: CommonColors.buttonorg,
                                                borderRadius: BorderRadius.circular(65),
                                              ),
                                              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("${prefList[index].title}",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.white),),
                                                ],
                                              )
                                          ),
                                        ):Container()
                                      )
                                    ],
                                  ),
                                ),
                                new SizedBox(height: 40,),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("General Info",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                                ),
                                new SizedBox(height: 20,),
                              ],
                            ),
                          ),

                          CustomlayoutView(icon: 'assets/zodiac_icon.png',tittle: 'Zodiac',status: '$zodiac_sign',),
                          CustomlayoutView(icon: 'assets/education_bottom.png',tittle: 'Education',status: '$education_level',),
                          CustomlayoutView(icon: 'assets/covid_bottom.png',tittle: 'COVID vaccine',status: '$covid_vaccine',),
                          CustomlayoutView(icon: 'assets/health_bottom.png',tittle: 'Health',status: '$healths',),
                          CustomlayoutView(icon: 'assets/persional_bottom.png',tittle: 'Personality type',status: "$personality_type",),

                          new SizedBox(height: 40,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.centerLeft,
                            child: Text("Lifestyle",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                          ),
                          new SizedBox(height: 20,),
                          CustomlayoutView(icon: 'assets/pet_icon.png',tittle: 'Pets',status: '$petss',),
                          CustomlayoutView(icon: 'assets/drink_bottom.png',tittle: 'Drinking',status: "$drinkings",),
                          CustomlayoutView(icon: 'assets/smoke_bottom.png',tittle: 'Smoking',status: '$smokings',),
                          CustomlayoutView(icon: 'assets/workout_bottom.png',tittle: 'Workout',status: '$workouts',),
                          CustomlayoutView(icon: 'assets/dientary_bottom.png',tittle: 'Dietary preference',status: '$dietary_preference',),
                          CustomlayoutView(icon: 'assets/social_bottom.png',tittle: 'Social media',status: '$social_media',),
                          CustomlayoutView(icon: 'assets/sleep_bottom.png',tittle: 'Sleeping habits',status: '$sleeping_habits',),
                          new SizedBox(height: 20,),
                          customwidget("Marriage plan","${marriage_plan}"),
                          customwidget("Job title","${jobTitle.text}"),
                          customwidget("Company","${company.text}"),
                          customwidget("Education","${education.text}"),
                          customwidget("Living in","${country}\n${state}\n${city}"),
                          customwidget("Religion","${religion}"),
                          customwidget("Caste","${caste}"),
                          customwidget("Mother tongue","${mother_tongue}"),
                          Container(
                              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text("Record voice message",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    height:50,
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                        // color: CommonColors.editblack,
                                        borderRadius: BorderRadius.circular(37),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.0,
                                      ),
                                    ),
                                    // child: InkWell(
                                    //   onTap: (){
                                    //     setState(() {
                                    //       _playAudio = !_playAudio;
                                    //     });
                                    //     if (_playAudio) startRecording();
                                    //     if (!_playAudio) stopRecording();
                                    //   },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          // new SizedBox(width: 20,),
                                          new Container(
                                            child: new Text("Voice not added",style: new TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: CommonColors.white),),
                                          ),
                                          // Spacer(),
                                          // new Container(
                                          //     child: Icon(Icons.arrow_forward_ios,color: CommonColors.edittextblack,size: 20,)
                                          // ),
                                          // new SizedBox(width: 20,),
                                        ],
                                      ),
                                    // ),
                                  ),
                                ],
                              )
                          ),
                          new SizedBox(height: 40,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            alignment: Alignment.center,
                            child: Text("SHARE THIS PROFILE ",style: new TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),textAlign: TextAlign.center,),
                          ),
                          new SizedBox(height: 60,),
                        ],
                      ),
                    ),
                  )
                  // Center(
                  //   child: Text("Comming soon",style: TextStyle(color: Colors.white),),
                  // )
                ],
              ),
            ),


          ],
        ),
      )
    );
  }
}

Widget customwidget(String key,value){
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text(key,style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
        ),
        SizedBox(height: 5,),
        Container(
          child: Text(value,style: TextStyle(color: Colors.white.withOpacity(0.5),fontSize: 13,fontWeight: FontWeight.w600),),
        ),
      ],
    )
  );
}

class EditText extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const EditText({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }
}