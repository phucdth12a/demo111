import 'package:get/get.dart';

import '../play_controller.dart';

class PlayBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.put(PlayController());
  }
}
