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

Future<void> removedLiked(String key) async {
  final likedBox = Hive.box('Favorite Songs');
  likedBox.delete(key);
}

Future<void> addItemToPlaylist(String name, MusicModel item) async {
  if (name != 'Favorite Songs') await Hive.openBox(name);
  final playlistBox = Hive.box(name);
  // final songs
  // item.dateAdded = DateTime.now();
  // songs_count.addSongsCount(name, len, images)
}
