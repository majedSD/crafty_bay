
import 'package:crafty_bay/data/model/creat_profile_params.dart';
import 'package:crafty_bay/data/model/profile.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Profile _profile = Profile();
  Profile get profile => _profile;

  Future<bool> createProfile(String token, CreateProfileParams params) async {
    _inProgress = true;
    update();
    final response = await NetworkCaller().postRequest(
      Urls.creatProfile,
       token: token,
      body: params.toJson(),
    );
    _inProgress = false;
    if (response.isSuccess) {
      _profile = Profile.fromJson(response.responseData['data']);
      await Get.find<AuthController>().setUserInformation(token, _profile);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage!;
      update();
      return false;
    }
  }
}