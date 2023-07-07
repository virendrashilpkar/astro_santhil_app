import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shadiapp/Models/age_height_range_model.dart';
import 'package:shadiapp/Models/city_list_model.dart';
import 'package:shadiapp/Models/country_list_model.dart';
import 'package:shadiapp/Models/delete_image_model.dart';
import 'package:shadiapp/Models/like_model.dart';
import 'package:shadiapp/Models/matchlist.dart';
import 'package:shadiapp/Models/my_matches_model.dart';
import 'package:shadiapp/Models/new_matches_model.dart';
import 'package:shadiapp/Models/otp_verify_model.dart';
import 'package:shadiapp/Models/phone_login_Model.dart';
import 'package:shadiapp/Models/plan_list_model.dart';
import 'package:shadiapp/Models/preference_list_model.dart';
import 'package:shadiapp/Models/top_picks_model.dart';
import 'package:shadiapp/Models/upload_image_model.dart';
import 'package:shadiapp/Models/user_add_preference_model.dart';
import 'package:shadiapp/Models/user_detail_model.dart';
import 'package:shadiapp/Models/user_list_model.dart';
import 'package:shadiapp/Models/user_update_model.dart';
import 'package:shadiapp/Models/user_view_preference_model.dart';
import 'package:shadiapp/Models/view_image_model.dart';
import 'package:shadiapp/Models/view_like_sent_model.dart';
import 'package:shadiapp/Models/view_profile_model.dart';

class Services {
  static String BaseUrl = "http://52.63.253.231:4000/api/v1/";

  static String Login = BaseUrl + "login";
  static String GoogleLogin = BaseUrl + "google/login";
  static String match_list = BaseUrl + "own/matches";
  static String OtpVerify = BaseUrl + "otp-verify";
  static String UserDetail = BaseUrl + "userDetails";
  static String UserUpdate = BaseUrl + "update";
  static String UploadImge = BaseUrl + "user/uploadImage/";
  static String ViewImage = BaseUrl + "user/images";
  static String PrefList = BaseUrl + "user/preference";
  static String AddPrefs = BaseUrl + "user/addpreference";
  static String UserList = BaseUrl + "users/list";
  static String ViewPrefs = BaseUrl + "user/preferenceList";
  static String LikeApi = BaseUrl + "user/creatematch";
  static String ViewProfile = BaseUrl + "profile";
  static String LikeView = BaseUrl + "sent/req";
  static String SetRange = BaseUrl + "set/range";
  static String MyMatches = BaseUrl + "own/matches";
  static String ListPlan = BaseUrl + "plan/list";
  static String TopPicks = BaseUrl + "top/pics";
  static String NewMatch = BaseUrl + "new/match";
  static String Country = BaseUrl + "country/list";
  static String City = BaseUrl + "city/list";
  static String ImageDelete = BaseUrl + "user/delete/image";

  static Future<PhoneLoginModel> LoginCrdentials(String phone) async {
    final params = {"phone": phone};
    print("PhoneLoginParams " + params.toString());
    http.Response response = await http.post(Uri.parse(Login), body: params);
    print("PhoneLoginResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PhoneLoginModel user = PhoneLoginModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }
  static Future<OtpVerifyModel> GoogleCrdentials(String token) async {
    final params = {"token": token};
    print("GoogleCrdentials " + params.toString());
    http.Response response = await http.post(Uri.parse(GoogleLogin), body: params);
    print("GoogleCrdentials" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OtpVerifyModel user = OtpVerifyModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }
  static Future<MatchList> MatchListMethod(String user_id) async {
    final params = {"id": user_id};
    // final params = {"id": "6452535298f7692c6a731291"};
    print("MatchListMethod" + params.toString());
    http.Response response = await http.post(Uri.parse(match_list), body: params);
    print("MatchListMethod" + response.body);

    if(response.statusCode == 200) {
      var data = jsonDecode(response.body);
      MatchList user = MatchList.fromJson(data);
      return user;
    }else{
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<OtpVerifyModel> Otp(String Id, String otp) async {
    final params = {"userId": Id, "otp": otp};
    print("OtpVerifyParams ${params.toString()}");
    http.Response response =
    await http.post(Uri.parse(OtpVerify), body: params);
    print("OtpVerifyResponse ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OtpVerifyModel user = OtpVerifyModel.fromJson(data);
      return user;
    } else {
      var data = jsonDecode(response.body);
      OtpVerifyModel user = OtpVerifyModel.fromJson(data);
      return user;
    }
  }

  static Future<UserDetailModel> UserDetailMethod(String uId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(UserDetail),
    );

    request.fields["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("UserDetailMethodParams ${request.fields}");
    print("UserDetailMethodResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UserDetailModel user = UserDetailModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<UpdateUserModel> UpdateUser(
      String uId,
      String firstName,
      String lastName,
      String birthDate,
      String gender,
      String country,
      String city,
      String height,
      String weight,
      String maritalStatus,
      String email,
      String lookinFor,
      String religion,
      String caste,
      String about,
      String education,
      String company,
      String jobTitle) async {
    final params = {
      "userId": uId,
      "first_name": firstName,
      "last_name": lastName,
      "birth_date": birthDate,
      "gender": gender,
      "country": country,
      "city": city,
      "height": height,
      "weight": weight,
      "marital_status": maritalStatus,
      "email": email,
      "looking_for": lookinFor,
      "religion": religion,
      "caste": caste,
      "education": education,
      "job_title": jobTitle,
      "company": company
    };

    print("UpdateUserParams " + params.toString());
    http.Response response =
    await http.post(Uri.parse(UserUpdate), body: params);
    print("UpdateUserResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      UpdateUserModel user = UpdateUserModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<UploadImageModel> ImageUpload(File image, String uId) async {
    var request =
    new http.MultipartRequest("POST", Uri.parse("${UploadImge}${uId}"));

    var file = await http.MultipartFile.fromPath("fileUrl", image.path);
    request.files.add(file);

    var response = await request.send();
    var response2 = await http.Response.fromStream(response);

    print(response.toString());
    print("ImageUpload " + response2.body);

    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UploadImageModel user = UploadImageModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<ViewImageModel> ImageView(String uId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(ViewImage),
    );

    request.fields["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("ImageViewParams ${request.fields}");
    print("ImageViewResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      ViewImageModel user = ViewImageModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<PreferenceListModel> PrefView(String uId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(PrefList),
    );

    request.fields["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("ImageViewParams ${request.fields}");
    print("ImageViewResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      PreferenceListModel user = PreferenceListModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<AddPreferenceModel> AddPrefsMethod(
      String uId, preferenceId) async {
    final params = {"userId": uId, "preferenceId": preferenceId};

    print("AddPrefsMethodParams " + params.toString());
    http.Response response = await http.post(Uri.parse(AddPrefs), body: params);
    print("AddPrefsMethodResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      AddPreferenceModel user = AddPreferenceModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<UserListModel> GetUserMethod(String uId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(UserList),
    );

    request.fields["id"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("GetUserMethodParams ${request.fields}");
    print("GetUserMethodResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UserListModel user = UserListModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<UserViewPreferenceModel> ViewUserPreference(String uId) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse(ViewPrefs),
    );

    request.fields["userId"] = uId;
    var response = await request.send();
    var response2 = await http.Response.fromStream(response);
    print("ViewPreferenceParams ${request.fields}");
    print("ViewPreferenceResponse ${response2.body}");
    if (response2.statusCode == 200) {
      var data = json.decode(response2.body);
      UserViewPreferenceModel user = UserViewPreferenceModel.fromJson(data);
      return user;
    } else {
      throw Exception('Failed');
    }
  }

  static Future<LikeModel> LikeMethod(
      String senderId, String receiverId, String type) async {
    final params = {"sender": senderId, "receiver": receiverId, "type": type};

    print("LikeMethodParams " + params.toString());
    http.Response response = await http.post(Uri.parse(LikeApi), body: params);
    print("LikeMethodResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      LikeModel user = LikeModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<ViewProfileModel> ProfileView(String id) async {
    final params = {"id": id};

    print("ProfileViewParams " + params.toString());
    http.Response response =
    await http.post(Uri.parse(ViewProfile), body: params);
    print("ProfileViewResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ViewProfileModel user = ViewProfileModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<ViewLikeSentModel> ViewLike(String id) async {
    final params = {"id": id};

    print("ViewLikeParams " + params.toString());
    http.Response response = await http.post(Uri.parse(LikeView), body: params);
    print("ViewLikeResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      ViewLikeSentModel user = ViewLikeSentModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<AgeHeightRangeModel> RangeSet(String id, int minAge, int maxAge, int minHeight, int maxHeight) async {
    final params = {
      "id": id,
      "minAge": minAge,
      "maxAge": maxAge,
      "minHeight": minHeight,
      "maxHeight": maxHeight
    };

    print("RangeSetParams " + params.toString());
    http.Response response = await http.post(Uri.parse(SetRange), body: params);
    print("RangeSetResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      AgeHeightRangeModel user = AgeHeightRangeModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<MyMatchesModel> MyMatchesList(String id) async {
    final params = {
      "id": id,
    };

    print("MyMatchesListParams " + params.toString());
    http.Response response = await http.post(Uri.parse(MyMatches), body: params);
    print("MyMatchesListResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      MyMatchesModel user = MyMatchesModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<PlanListModel> PlanList() async {

    http.Response response = await http.get(Uri.parse(ListPlan));
    print("PlanListResponse" + response.body);
    print("PlanListResponse ${response.statusCode}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PlanListModel user = PlanListModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<TopPicksModel> TopPicksList(String id) async {
    final params = {
      "userId": id,
    };

    print("TopPicksListParams " + params.toString());
    http.Response response = await http.post(Uri.parse(TopPicks), body: params);
    print("TopPicksListResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      TopPicksModel user = TopPicksModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<NewMatchesModel> NewMatchesList(String id) async {
    final params = {
      "id": id,
    };

    print("NewMatchesListParams " + params.toString());
    http.Response response = await http.post(Uri.parse(NewMatch), body: params);
    print("NewMatchesListResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      NewMatchesModel user = NewMatchesModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<CountryListModel> CountryList() async {

    http.Response response = await http.post(Uri.parse(Country));
    print("CountryListResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      CountryListModel user = CountryListModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }

  static Future<CItyListModel> CityList(String name) async {

    final params = {
      "name": name
    };

    print("CityListResponse $params");
    http.Response response = await http.post(Uri.parse(City), body: params);
    print("CityListResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      CItyListModel user = CItyListModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      var data = jsonDecode(response.body);
      CItyListModel user = CItyListModel.fromJson(data);
      return user;
      // throw Exception('Failed');
    }
  }

  static Future<DeleteImageModel> DeleteImage(String imageId) async {

    final params = {
      "id": imageId
    };

    print("DeleteImageResponse $params");
    http.Response response = await http.delete(Uri.parse(ImageDelete), body: params);
    print("DeleteImageResponse" + response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DeleteImageModel user = DeleteImageModel.fromJson(data);
      return user;
    } else {
      print(response.body);
      throw Exception('Failed');
    }
  }
}
