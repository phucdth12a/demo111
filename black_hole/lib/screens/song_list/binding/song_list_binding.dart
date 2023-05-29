import 'package:get/get.dart';

import '../song_list_controller.dart';

class SongListBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.put(SongListController());
  }
}
