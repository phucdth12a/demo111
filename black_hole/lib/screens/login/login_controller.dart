import 'package:black_hole/helpers/backup_restore.dart';
import 'package:black_hole/helpers/config.dart';
import 'package:black_hole/helpers/supabase.dart';
import 'package:black_hole/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class LoginController extends GetxController {
  final textEditingController = TextEditingController();
  final uuid = const Uuid();

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future addUserData(String name) async {
    await Hive.box('settings').put('name', name.trim());
    final now = DateTime.now();
    final createDate = now
        .toUtc()
        .add(const Duration(hours: 5, minutes: 30))
        .toString()
        .split('.')
      ..removeLast()
      ..join('.');

    final userId = uuid.v1();
    await SupaBase().createUser({
      'id': userId,
      'name': name,
      'accountCreatedOn': '${createDate[0]} IST',
      'timeZone':
          'Zone ${now.timeZoneName} Offset: ${now.timeZoneOffset.toString().replaceAll('.000000', '')}',
    });
    await Hive.box('settings').put('userId', userId);
  }

  skipAction() async {
    await addUserData('guest'.tr);
    Get.offAndToNamed(Routes.pref);
  }

  restoreAction() async {
    await restore();
    GetIt.I<MyTheme>().refresh();
    if (Hive.box('settings').get('userId') != null) {
      Get.offAllNamed(Routes.home);
    }
  }

  onSubmitAction() async {
    final value = textEditingController.text;
    await addUserData(value.trim() == '' ? 'guest'.tr : value);
    Get.offAndToNamed(Routes.pref);
  }
}
