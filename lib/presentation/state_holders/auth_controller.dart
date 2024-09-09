import 'dart:convert';
import 'package:crafty_bay/data/model/profile.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/verify_email_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static String? token;
  static Profile? userProfile;

  Future<void> setUserInformation(String t, Profile p) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', t);
    sharedPreferences.setString('profile', jsonEncode(p.toJson()));
    await getUserInformation();
    update();
  }

  Future<void> updateUserInformation(Profile profile) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('profile', jsonEncode(profile.toJson()));
    await getUserInformation();
    update();
  }

  Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    userProfile = Profile.fromJson(
        jsonDecode(sharedPreferences.getString('profile') ?? '{}'));
    update();
  }

  Future<void> clearAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
    userProfile=null;
  }
  static Future<void>backToLogin()async{
    token=null;
    Get.offAll(()=>const VerifyEmailScreen());
  }
  Future<bool> checkAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    userProfile = Profile.fromJson(
        jsonDecode(sharedPreferences.getString('profile') ?? '{}'),);
    update();
    if (token != null && userProfile != null) {
      return true;
    }
    return false;
  }
}
