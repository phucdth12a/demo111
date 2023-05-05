import 'package:black_hole/custom_widget.dart/snackbar.dart';
import 'package:black_hole/routes/routes.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class PrefController extends GetxController {
  final languages = [
    'Hindi',
    'English',
    'Punjabi',
    'Tamil',
    'Telugu',
    'Marathi',
    'Gujarati',
    'Bengali',
    'Kannada',
    'Bhojpuri',
    'Malayalam',
    'Urdu',
    'Haryanvi',
    'Rajasthani',
    'Odia',
    'Assamese'
  ];
  var isSelected = [true, false].obs;
  var preferredLanguage = (Hive.box('settings')
          .get('preferredLanguage', defaultValue: ['Hindi']) as List)
      .obs;
  var region =
      (Hive.box('settings').get('region', defaultValue: 'India') as String).obs;
  var checked = [].obs;

  skipAction() {
    Get.offAndToNamed(Routes.home);
  }

  saveLanguage() {
    Get.back();
    preferredLanguage = checked;
    Hive.box('settings').put('preferredLanguage', checked);
    if (preferredLanguage.isEmpty) {
      ShowSnackBar().showSnackBar('noLangSelected'.tr);
    }
  }

  saveRegion(String value) {
    Get.back();
    region.value = value;
    Hive.box('settings').put('region', region.value);
  }
}
