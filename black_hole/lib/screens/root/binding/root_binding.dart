import 'package:black_hole/screens/root/root_controller.dart';
import 'package:get/get.dart';

class RootBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.put(RootController());
  }
}
