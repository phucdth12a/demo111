import 'dart:io';

import 'package:black_hole/model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

class Download with ChangeNotifier {
  static final Map<String, Download> _instances = {};
  final String id;

  factory Download(String id) {
    if (_instances.containsKey(id)) {
      return _instances[id]!;
    } else {
      final instance = Download._internal(id);
      _instances[id] = instance;
      return instance;
    }
  }

  Download._internal(this.id);

  int? rememberOption;
  final ValueNotifier<bool> remember = ValueNotifier<bool>(false);
  String preferredDownloadQuality =
      Hive.box('settings').get('downloadQuality', defaultValue: '320 kbps');
  String preferredYtDownloadQuality =
      Hive.box('settings').get('ytDownloadQuality', defaultValue: 'High');
  String downloadFormat =
      Hive.box('settings').get('downloadFormat', defaultValue: 'm4a');
  bool createDownloadFolder =
      Hive.box('settings').get('createDownloadFolder', defaultValue: false);
  bool createYoutubeFolder =
      Hive.box('settings').get('createYoutubeFolder', defaultValue: false);
  double? progress = 0.0;
  String lastDownloadId = '';
  bool downloadLyrics =
      Hive.box('settings').get('downloadLyrics', defaultValue: false);
  bool download = true;

  Future<void> prepareDownload(
    MusicModel data, {
    bool createFolder = false,
    String? folderName,
  }) async {
    Logger.root.info('Prepareing download for ${data.title}');
    download = true;
    if (!Platform.isWindows) {
      Logger.root.info('Requesting storage permission');
      PermissionStatus status = await Permission.storage.status;
      if (status.isDenied) {
        Logger.root.info('Request denied');
        await [
          Permission.storage,
          Permission.accessMediaLocation,
          Permission.mediaLibrary,
        ].request();
      }
      status = await Permission.storage.status;
      if (status.isPermanentlyDenied) {
        Logger.root.info('Request permanently denied');
        await openAppSettings();
      }
    }
    final RegExp avoid = RegExp(r'[\.\\\*\:\"\?#/;\|]');
    data.title = data.title?.split('(From')[0].trim();

    String fileName = '';
    final int downFileName =
        Hive.box('settings').get('downFileName', defaultValue: 0);
    if (downFileName == 0) {
      fileName = '${data.title} - ${data.artist}';
    } else if (downFileName == 1) {
      fileName = '${data.artist} - ${data.title}';
    }
  }
}
