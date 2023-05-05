import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class ShowSnackBar {
  void showSnackBar(String title,
      {SnackBarAction? action,
      Duration duration = const Duration(seconds: 1),
      bool noAction = false}) {
    try {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          duration: duration,
          elevation: 6,
          backgroundColor: Colors.grey[900],
          behavior: SnackBarBehavior.floating,
          content: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          action: noAction
              ? null
              : action ??
                  SnackBarAction(
                    textColor: Theme.of(Get.context!).colorScheme.secondary,
                    label: 'ok'.tr,
                    onPressed: () {},
                  ),
        ),
      );
    } catch (e) {
      Logger.root.info('Failed to show snackbar with title: $title', e);
    }
  }
}
