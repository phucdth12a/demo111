import 'package:get/get.dart';

import '../pref_controller.dart';

class PrefBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrefController());
  }
}
