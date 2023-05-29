import 'package:black_hole/screens/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
