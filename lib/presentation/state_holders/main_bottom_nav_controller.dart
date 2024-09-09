import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class MainBottomNavController extends GetxController {
  int _selecteIndex = 0;

  int get currentIndex => _selecteIndex;

  void changeIndex(int index) {
    _selecteIndex = index;
     update();
    if ((_selecteIndex==2||_selecteIndex==3) && Get.find<AuthController>().checkAuthState()==false) {
       AuthController.backToLogin();
       return;
     }
  }
  void backToHome() {
    changeIndex(0);
  }
}
