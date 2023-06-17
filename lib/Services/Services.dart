
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shadiapp/Models/otp_verify_model.dart';
import 'package:shadiapp/Models/phone_login_Model.dart';
import 'package:shadiapp/Models/preference_list_model.dart';
import 'package:shadiapp/Models/upload_image_model.dart';
import 'package:shadiapp/Models/user_add_preference_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_list_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Models/view_image_model.dart';

class Services {

  static String BaseUrl = "http://192.168.2.2:4000/api/v1/";

  static String Login = BaseUrl+"login";
  static String OtpVerify = BaseUrl+"otp-verify";
  static String UserDetail = BaseUrl+"userDetails";
  static String UserUpdate = BaseUrl+"update";
  static String UploadImge = BaseUrl+"user/uploadImage/";
  static String ViewImage = BaseUrl+"user/images";
  static String PrefList = BaseUrl+"user/preference";
  static String AddPrefs = BaseUrl+"user/addpreference";
  static String UserList = BaseUrl+"users/list";

  static Future<PhoneLoginModel> LoginCrdentials(String phone) async {
    final params = {
      "phone" : phone
    };
    print("PhoneLoginParams "+params.toString());
    http.Response response = await http.post(Uri.parse(Login), body: params);
    print("PhoneLoginResponse"+response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PhoneLoginModel user = PhoneLoginModel.fromJson(data);
      return user;
    }else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<OtpVerifyModel> Otp(String Id, String otp) async{
    final params = {
      "userId" : Id,
      "otp": otp
    };
    print("OtpVerifyParams ${params.toString()}");
    http.Response response = await http.post(Uri.parse(OtpVerify), body: params);
    print("OtpVerifyResponse ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OtpVerifyModel user = OtpVerifyModel.fromJson(data);
      return user;
    }else {
      print("ErrorOtpVerifyResponse ${response.body}");
      throw Exception('Failed');
    }
  }

  static Future<UserDetailModel> UserDetailMethod(String uId) async{

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(UserDetail),
    );

    request.fields  ["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("UserDetailMethodParams ${request.fields}");
    print("UserDetailMethodResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UserDetailModel user = UserDetailModel.fromJson(data);
      return user;
    }else {
      throw Exception('Failed');
    }
  }

  static Future<UpdateUserModel> UpdateUser(String uId, String firstName, String lastName, String birthDate, String gender,
      String country, String city, String height, String weight, String maritalStatus, String email, String lookinFor) async {

    final params = {
      "userId" : uId,
      "first_name" : firstName,
      "last_name" : lastName,
      "birth_date" : birthDate,
      "gender" : gender,
      "country" : country,
      "city" : city,
      "height" : height,
      "weight" : weight,
      "marital_status" : maritalStatus,
      "email" : email,
      "looking_for" : lookinFor,

    };

    print("UpdateUserParams "+params.toString());
    http.Response response = await http.post(Uri.parse(UserUpdate), body: params);
    print("UpdateUserResponse"+response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UpdateUserModel user = UpdateUserModel.fromJson(data);
      return user;
    }else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<UploadImageModel> ImageUpload(File image, String uId) async {

    var request = new http.MultipartRequest(
        "POST",
        Uri.parse("${UploadImge}${uId}")
    );

    var file = await http.MultipartFile.fromPath("fileUrl", image.path);
    request.files.add(file);

    var response = await request.send();
    var response2 = await http.Response.fromStream(response);

    print(response.toString());
    print("ImageUpload "+response2.body);

    if (response2.statusCode == 200){
      var data = json.decode(response2.body);
      UploadImageModel user = UploadImageModel.fromJson(data);
      return user;
    }else{
      throw Exception('Failed');
    }
  }

  static Future<ViewImageModel> ImageView(String uId) async {

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(ViewImage),
    );

    request.fields  ["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("ImageViewParams ${request.fields}");
    print("ImageViewResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      ViewImageModel user = ViewImageModel.fromJson(data);
      return user;
    }else {
      throw Exception('Failed');
    }
  }

  static Future<PreferenceListModel> PrefView(String uId) async {

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(PrefList),
    );

    request.fields  ["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("ImageViewParams ${request.fields}");
    print("ImageViewResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      PreferenceListModel user = PreferenceListModel.fromJson(data);
      return user;
    }else {
      throw Exception('Failed');
    }
  }

  static Future<AddPreferenceModel> AddPrefsMethod(String uId, preferenceId) async {

    final params = {
      "userId" : uId,
      "preferenceId": preferenceId
    };

    print("AddPrefsMethodParams "+params.toString());
    http.Response response = await http.post(Uri.parse(AddPrefs), body: params);
    print("AddPrefsMethodResponse"+response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      AddPreferenceModel user = AddPreferenceModel.fromJson(data);
      return user;
    }else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<UserListModel> GetUserMethod(String uId) async {

    var request = http.MultipartRequest(
      'GET',
      Uri.parse(UserList),
    );

    request.fields  ["id"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("GetUserMethodParams ${request.fields}");
    print("GetUserMethodResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UserListModel user = UserListModel.fromJson(data);
      return user;
    }else {
      throw Exception('Failed');
    }
  }
}