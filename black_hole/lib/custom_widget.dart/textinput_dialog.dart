import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> showTextInputDialog({
  required String title,
  String? initialtext,
  required TextInputType keyboardType,
  required Function(String) onSubmitted,
}) async {
  await showDialog(
    context: Get.context!,
    builder: (context) {
      final controller = TextEditingController(text: initialtext);
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              ],
            ),
            TextField(
              autofocus: true,
              controller: controller,
              keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.bottom,
              onSubmitted: (value) {
                onSubmitted(value.trim());
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.grey[700],
            ),
            onPressed: () => Get.back(),
            child: Text('cancel'.tr),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor:
                  Theme.of(context).colorScheme.secondary == Colors.white
                      ? Colors.black
                      : Colors.white,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => onSubmitted(controller.text.trim()),
            child: Text('ok'.tr),
          ),
          const SizedBox(width: 5),
        ],
      );
    },
  );
}
