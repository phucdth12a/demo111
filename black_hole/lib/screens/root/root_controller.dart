import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RootController extends GetxController {
  var selectedIndex = 0.obs;
  var appVersion = ''.obs;

  var sectionsToShow = (Hive.box('settings').get('sectionToShow',
          defaultValue: ['Home', 'Top Charts', 'Youtube', 'Library']) as List)
      .obs;

  final scrollController = ScrollController();
  final pageController = PageController();

  @override
  void onClose() {
    scrollController.dispose();
    pageController.dispose();
    super.onClose();
  }

  Future<bool> handleWillPop() async {
    return true;
  }

  onItemTapped(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }

  goFolderMusicAction() {
    Get.back();
    // Get.toNamed('/');
  }

  goDownloadAction() {
    Get.back();
    // Get.toNamed(page)
  }

  goPlayListAction() {
    Get.back();
    // Get.toNamed(page)
  }

  goSettingsAction() {
    Get.back();
    // Get.toNamed(page)
  }

  goAboutAction() {
    Get.back();
    // Get.toNamed(page)
  }
}
