import 'package:audio_service/audio_service.dart';
import 'package:black_hole/helpers/mediaitem_converter.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:black_hole/Helpers/songs_count.dart' as songs_count;

bool checkPlaylist(String name, String key) {
  if (name != 'Favorite Songs') {
    Hive.openBox(name).then((value) {
      return Hive.box(name).containsKey(key);
    });
  }
  return Hive.box(name).containsKey(key);
}

Future<void> removeLiked(String key) async {
  final likedBox = Hive.box('Favorite Songs');
  likedBox.delete(key);
}

Future<void> addMapToPlaylist(String name, MusicModel info) async {
  if (name != 'Favorite Songs') await Hive.openBox(name);
  final Box playlistBox = Hive.box(name);
  final List songs = playlistBox.values.toList();
  info.dateAdded = DateTime.now();
  songs_count.addSongsCount(
    name,
    playlistBox.values.length + 1,
    songs.length >= 4 ? songs.sublist(0, 4) : songs.sublist(0, songs.length),
  );
  playlistBox.put(info.id, info);
}

Future<void> addItemToPlaylist(String name, MediaItem mediaItem) async {
  if (name != 'Favorite Songs') await Hive.openBox(name);
  final Box playlistBox = Hive.box(name);
  final Map info = MediaItemConverter.mediaItemToMap(mediaItem);
  info.addEntries([MapEntry('dateAdded', DateTime.now().toString())]);
  final List songs = playlistBox.values.toList();
  songs_count.addSongsCount(
    name,
    playlistBox.values.length + 1,
    songs.length >= 4 ? songs.sublist(0, 4) : songs.sublist(0, songs.length),
  );
  playlistBox.put(mediaItem.id, info);
}
