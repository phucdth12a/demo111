import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:black_hole/screens/player/audioplayer.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../helpers/mediaitem_converter.dart';

class PlayerInvoke {
  static final AudioPlayerHandler audioHandler = GetIt.I<AudioPlayerHandler>();

  static Future<void> init({
    required List<MusicModel> songList,
    required int index,
    bool fromMiniplayer = false,
    bool? isOffline,
    bool recomend = true,
    bool fromDownloads = false,
    bool shuffe = false,
    String? playlistBox,
  }) async {
    final globalIndex = index < 0 ? 0 : index;
    bool? offline = isOffline;
    final finalList = songList;
    if (shuffe) finalList.shuffle();
    if (offline == null) {
      if (audioHandler.mediaItem.value?.extras!['url'].startsWith('http')
          as bool) {
        offline = false;
      } else {
        offline = true;
      }
    } else {
      offline = offline;
    }

    if (!fromMiniplayer) {
      if (!Platform.isAndroid) {
        // Don't know why but it fixes the playback issue with iOS Side
        audioHandler.stop();
      }
      if (offline) {
        fromDownloads ? setDownloadValues(finalList, globalIndex) : (Platform.isWindows || Platform.isLinux) ? 
      }
    }
  }

  static Future<MediaItem> setTags(MusicModel response, Directory tempDir) async {
    return const MediaItem(id: '12', title: '1');
  }

  static void setOffDesktopValues(List<MusicModel> response, int index) {
    getTemporaryDirectory().then((tempDir) async {
      final File file = File('${tempDir.path}/cover.jpg');
      if (!await file.exists()) {
        final byteData = await rootBundle.load('assets/cover.jpg');
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),);
      }
      final List<MediaItem> queue = [];
      queue.addAll(response.map((song) => MediaItem(
            id: song.id ?? '',
            album: song.album ?? '',
            artist: song.artist ?? '',
            duration: Duration(
              seconds: int.parse(
                (song.duration == null || song.duration == 'null')
                    ? '180'
                    : song.duration ?? '',
              ),
            ),
            title: song.title ?? '',
            artUri: Uri.file(file.path),
            genre: song.genre ?? '',
            extras: {
              'url': song.path ?? '',
              'subtitle': song.subtitle ?? '',
              'quality': song.quality ?? '',
            },
          ),),);
          updateNplay(queue, index);
    });
  }

  static void setOffValues(List<MusicModel> response, int index) {
    getTemporaryDirectory().then((tempDir) async {
      final File file = File('${tempDir.path}/cover.jpg');
      if (!await file.exists()) {
        final byteData = await rootBundle.load('assets/cover.jpg');
        await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),);
      }
      final List<MediaItem> queue = [];
      for (int i = 0)
    });
  }

  static void setDownloadValues(List<MusicModel> response, int index) {
    final List<MediaItem> queue = [];
    queue.addAll(response.map((e) => MediaItemConverter.downloadMapToMediaItem(e),),);
    updateNplay(queue, index);
  }

  static Future<void> updateNplay(List<MediaItem> queue, int index) async {
    await audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    await audioHandler.updateQueue(queue);
    await audioHandler.customAction('skipToMediaItem', {'id': queue[index].id});
    await audioHandler.play();
    final String repeatMode = Hive.box('settings').get('repeatMode', defaultValue: 'None');
    final bool enforceRepeat = Hive.box('settings').get('enforceRepeat', defaultValue: false);
    if (enforceRepeat) {
      switch (repeatMode) {
        case 'None':
        audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
        case 'All':
        audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
        case 'One':
        audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
        default:
        break;
      }
    } else {
      audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
      Hive.box('settings').put('repeatMode', 'None');
    }
    }
}
