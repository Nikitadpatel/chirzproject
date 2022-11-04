import 'dart:convert';
import 'package:chirz/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SaveDataLocal {
  static SharedPreferences? prefs;
  static String userData = 'UserData';
  static String calenderEventData = 'CalenderEvent';
  static saveLogInData(UserModel userModel) async {
    prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(userModel.toJson());
    await prefs?.setString(userData, json);
  }
  static getDataFromLocal() async {
    prefs = await SharedPreferences.getInstance();

    String? userString = prefs?.getString(userData);
    if (userString != null) {
      Map userMap = jsonDecode(userString);
      UserModel user = UserModel.fromJson(userMap);
      return user;
    } else {
      return null;
    }
  }

  static clearUserData() async {
    prefs = await SharedPreferences.getInstance();
    prefs?.clear();
  }
}
