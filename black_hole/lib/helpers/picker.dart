import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';

class Picker {
  static Future<String> selectFolder({String? message}) async {
    final String? temp =
        await FilePicker.platform.getDirectoryPath(dialogTitle: message);
    Logger.root.info('Selected folder: $temp');
    return (temp == '/' || temp == null) ? '' : temp;
  }

  static Future<String> selectFile({String? message}) async {
    final result = await FilePicker.platform.pickFiles(dialogTitle: message);
    if (result != null) {
      final file = File(result.files.first.path ?? '');
      return file.path == '/' ? '' : file.path;
    }
    return '';
  }
}
