import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:shadiapp/CommonMethod/Toaster.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Services/Services.dart';
import 'package:shadiapp/ShadiApp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class NameDOB extends StatefulWidget {
  @override
  State<NameDOB> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<NameDOB> {

  bool ActiveConnection = false;
  String T = "";
  SharedPreferences? _preferences;
  late UserDetailModel _userDetailModel;
  late UpdateUserModel _updateUserModel;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController intialdateval = TextEditingController();
  String dateOfBirth = "";
  String gender = "";
  String country = "";
  String city = "";
  String state = "";
  String height = "";
  String weight = "";
  String maritalStatus = "";
  String email = "";
  String lookingFor = "";
  String religion = "";
  String caste = "";
  String about = "";
  String education = "";
  String company = "";
  String jobTitle = "";

  bool clickLoad = false;

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

  String zodiac_sign = "";
  String education_level = "";
  String covid_vaccine = "";
  String pets = "";
  String dietary_preference = "";
  String sleeping_habits = "";
  String social_media = "";
  String workout = "";
  String smoking = "";
  String health = "";
  String drinking = "";
  String personality_type = "";
  Future<void> userDetail() async {
    _preferences = await SharedPreferences.getInstance();
    _userDetailModel = await Services.UserDetailMethod("${_preferences?.getString(ShadiApp.userId)}");
    if(_userDetailModel.status == 1){
      firstName.text = _userDetailModel.data![0].firstName.toString();
      lastName.text = _userDetailModel.data![0].lastName.toString();
      if(_userDetailModel.data![0].birthDate == null){
        intialdateval.text = "";
      }else {
        intialdateval.text = convertDateFormat(_userDetailModel.data![0].birthDate.toString().substring(0, 10).replaceAll("-", "/"));
        // intialdateval.text = _userDetailModel.data![0].birthDate.toString().substring(0, 10).replaceAll("-", "/");
      }
      gender = _userDetailModel.data![0].gender.toString();
      country = _userDetailModel.data![0].country.toString();
      city = _userDetailModel.data![0].city.toString();
      state = _userDetailModel.data![0].state.toString();
      weight = _userDetailModel.data![0].weight.toString();
      height = _userDetailModel.data![0].height.toString();
      maritalStatus = _userDetailModel.data![0].maritalStatus.toString();
      email = _userDetailModel.data![0].email.toString();
      religion = _userDetailModel.data![0].religion.toString();
      caste = _userDetailModel.data![0].caste.toString();
      about = _userDetailModel.data![0].about.toString();
      education = _userDetailModel.data![0].education.toString();
      company = _userDetailModel.data![0].company.toString();
      jobTitle = _userDetailModel.data![0].jobTitle.toString();
      personality_type = _userDetailModel.data![0].personalityType.toString();
      setState(() {

      });
    }
  }


  String convertDateFormat(String inputDate) {
    // Define the input date format
    final inputFormat = DateFormat('yyyy/MM/dd');

    // Parse the input date string to a DateTime object
    final dateTime = inputFormat.parseStrict(inputDate);

    // Define the desired output date format
    final outputFormat = DateFormat('dd/MM/yyyy');

    // Format the DateTime object to the desired output format
    return outputFormat.format(dateTime);
  }


  Future<void> updateUser() async {
    setState(() {
      clickLoad = true;
    });
    _preferences = await SharedPreferences.getInstance();
    // Define the input date format
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    // Parse the input date string
    DateTime dateTime = inputFormat.parse(intialdateval.text);
    DateFormat outputFormat = DateFormat("yyyy-MM-dd");
    String outputDate = outputFormat.format(dateTime);
    _updateUserModel = await Services.UpdateUser2(
        {
          "userId": "${_preferences?.getString(ShadiApp.userId)}",
          "first_name": firstName.text,
          "last_name": lastName.text,
          "birth_date": outputDate,
        }
    );
    if(_updateUserModel.status == 1){
      Toaster.show(context, _updateUserModel.message.toString());
      Navigator.of(context).pushNamed('HeightWeight');
    }else{
      Toaster.show(context, _updateUserModel.message.toString());
    }
    setState(() {
      clickLoad = false;
    });
  }

  @override
  void initState() {
    userDetail();
    CheckUserConnection();
    super.initState();

  }



  //
  // Future _selectDate() async {
  //   DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: new DateTime.now(),
  //       firstDate: new DateTime(2020),
  //       lastDate: new DateTime(2030));
  //   if (picked != null)
  //     setState(() => {
  //           intialdateval.text = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}"
  //
  //         }
  //     );
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.themeblack,
      body: SingleChildScrollView(
        child: Center(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new SizedBox(height: MediaQuery.of(context).padding.top+20,),
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
              new SizedBox(height: 40,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 17,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: firstName,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'First name',
                    border: InputBorder.none,
                    hintStyle: new TextStyle(color: Colors.grey,fontSize: 16),
                  ),
                  style: new TextStyle(color: Colors.white,fontSize: 16),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _phoneNumber = value!;
                  },
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  controller: lastName,
                  textCapitalization: TextCapitalization.sentences,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Surname',
                    border: InputBorder.none,
                    hintStyle: new TextStyle(color: Colors.grey,fontSize: 16),
                  ),
                  style: new TextStyle(color: Colors.white,fontSize: 16),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    // _phoneNumber = value!;
                  },
                ),
              ),
              new SizedBox(height: 15,),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Your birthday is',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              new SizedBox(height: 15,),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  autocorrect: false,
                  // readOnly: true,
                  controller: intialdateval,
                  decoration: InputDecoration(
                    hintText: 'DD/MM/YYYY',
                    border: InputBorder.none,
                    hintStyle: new TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w400),
                  ),
                  style: new TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w400),
                  // onTap: () {
                  //   _selectDate();
                  //   FocusScope.of(context).requestFocus(new FocusNode());
                  // },
                  inputFormatters: [
                    DateTextFormatter(),
                  ],
                  maxLines: 1,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 1) {
                      return 'Choose Date';
                    }
                  },
                  onSaved: (value) {
                    // _phoneNumber = value!;
                  },
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 14,bottom: 14,left: 28,right: 28),
                child: Text(
                  'This will appear on Shaadi-App, and you will not be able to change it.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                              child: Text("Continue", style: TextStyle(
                                  color: Colors.white, fontSize: 20,fontWeight: FontWeight.w600,),),
                            )),
                      ],
                    ),
                    SizedBox.expand(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(onTap: () {
                          if(firstName.text.isEmpty) {
                            Toaster.show(context, "Pelase Enter First Name");
                          }else if (lastName.text.isEmpty){
                            Toaster.show(context, "Pelase Enter surname");
                          }else if (intialdateval.text.isEmpty){
                            Toaster.show(context, "Pelase Enter Date of Birth");
                          }else if(!isDateValid(intialdateval.text)){
                            Toaster.show(context, "Date of Birth is not valid");
                          }else{
                            updateUser();
                          }

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
            ],
          ),
        ),
      ),
    );



  }
  bool isDateValid(String input) {
    final match = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(input);
    if (match == null) {
      return false; // Input doesn't match the expected format
    }

    try {
      final day = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final year = int.parse(match.group(3)!);

      if (day < 1 || day > 31 || month < 1 || month > 12) {
        return false; // Invalid day or month
      }

      return true;
    } catch (e) {
      return false; // Date parsing failed
    }
  }
}





class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String separator = '/';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
      String value,
      String oldValue,
      String separator,
      ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
      TextEditingValue oldValue,
      String text,
      ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    var selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }


  bool isDateValid(String input) {
    final match = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$').firstMatch(input);
    if (match == null) {
      return false; // Input doesn't match the expected format
    }

    try {
      final day = int.parse(match.group(1)!);
      final month = int.parse(match.group(2)!);
      final year = int.parse(match.group(3)!);

      if (day < 1 || day > 31) {
        return false; // Invalid day
      }

      if (month < 1 || month > 12) {
        return false; // Invalid month
      }

      return true;
    } catch (e) {
      return false; // Date parsing failed
    }
  }


}