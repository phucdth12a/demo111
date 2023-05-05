import 'dart:io';

import 'package:black_hole/custom_widget.dart/snackbar.dart';
import 'package:black_hole/helpers/picker.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> createBackup(
  List items,
  Map<String, List> boxNameData, {
  String? path,
  String? fileName,
  bool showDialog = true,
}) async {
  if (!Platform.isWindows) {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      await [
        Permission.storage,
        Permission.accessMediaLocation,
        Permission.mediaLibrary,
      ].request();
    }
    status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
  final savePath =
      path ?? await Picker.selectFolder(message: 'selectBackLocation'.tr);
  if (savePath.trim() != '') {
    try {
      final saveDir = Directory(savePath);
      final List<File> files = [];
      final List boxNames = [];

      for (int i = 0; i < items.length; i++) {
        boxNames.addAll(boxNameData[items[i]]!);
      }

      for (int i = 0; i < boxNames.length; i++) {
        await Hive.openBox(boxNames[i].toString());
        try {
          await File(Hive.box(boxNames[i].toString()).path!)
              .copy('$savePath/${boxNames[i]}.hive');
        } catch (e) {
          await [
            Permission.manageExternalStorage,
          ].request();
          await File(Hive.box(boxNames[i].toString()).path!)
              .copy('$savePath/${boxNames[i]}.hive');
        }

        files.add(File('$savePath/${boxNames[i]}.hive'));
      }

      final now = DateTime.now();
      final time = '${now.hour}${now.minute}_${now.day}${now.month}${now.year}';
      final zipFile =
          File('$savePath/${fileName ?? 'BlaclHole_Backup_$time'}.zip');

      await ZipFile.createFromFiles(
        sourceDir: saveDir,
        files: files,
        zipFile: zipFile,
      );

      for (int i = 0; i < files.length; i++) {
        files[i].delete();
      }
      if (showDialog) {
        ShowSnackBar().showSnackBar('backupSuccess'.tr);
      }
    } catch (e) {
      Logger.root.severe('Error in creating backup', e);
      ShowSnackBar().showSnackBar('${'failedCreateBackup'.tr}\nError: $e');
    }
  }
}

Future<void> restore() async {
  final savePath = await Picker.selectFile(message: 'selectBackFile'.tr);
  final zipFile = File(savePath);
  final tempDir = await getTemporaryDirectory();
  final destinationDir = Directory('${tempDir.path}/restore');

  if (savePath.isEmpty) return;

  try {
    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: destinationDir,
    );
    final files = await destinationDir.list().toList();

    for (int i = 0; i < files.length; i++) {
      final backupPath = files[i].path;
      final boxName = backupPath.split('/').last.replaceAll('.hive', '');
      final box = await Hive.openBox(boxName);
      final boxPath = box.path!;
      await box.close();

      try {
        await File(backupPath).copy(boxPath);
      } finally {
        await Hive.openBox(boxName);
      }

      destinationDir.delete(recursive: true);
      ShowSnackBar().showSnackBar('importSuccess'.tr);
    }
  } catch (e) {
    Logger.root.severe('Error in restoring backup', e);
    ShowSnackBar().showSnackBar('${'failedImport'.tr}\nError: $e');
  }
}
