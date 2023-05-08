import 'package:hive_flutter/hive_flutter.dart';

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
