import 'package:crafty_bay/data/models/response_data.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/read_profile_data_controller.dart';
import 'package:get/get.dart';

class OtpVerificationController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';
  bool _shouldNavigateCompleteProfile = true;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  bool get shouldNavigateCompleteProfile => _shouldNavigateCompleteProfile;

  String _token = '';
  String get token => _token;

  Future<bool> otpVerification(String email, String otp) async {
    _inProgress = true;
    update();

    final ResponseData response =
    await NetworkCaller.getRequest(Urls.otpVerify(email, otp));
    _inProgress = false;
    if (response.isSuccess) {
      _token = response.responseData['data'];
      await Future.delayed(const Duration(seconds: 2));
      final result =
      await Get.find<ReadProfileDataController>().readProfileData(token);
      if (result) {
        _shouldNavigateCompleteProfile =
            Get.find<ReadProfileDataController>().isProfileCompleted == false;
        if (_shouldNavigateCompleteProfile == false) {
          Get.find<AuthController>().saveUserDetails(
              token, Get.find<ReadProfileDataController>().profile);
        }
      } else {
        _errorMessage = Get.find<ReadProfileDataController>().errorMessage;
        update();
        return false;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}