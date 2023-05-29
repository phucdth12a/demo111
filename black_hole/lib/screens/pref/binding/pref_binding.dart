import 'package:get/get.dart';

import '../pref_controller.dart';

class PrefBiding extends BindingsInterface {
  @override
  void dependencies() {
    Get.put(PrefController());
  }
}
