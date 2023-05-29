import 'package:black_hole/api/api.dart';
import 'package:black_hole/custom_widget.dart/snackbar.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class SongListController extends GetxController {
  int page = 1;
  bool loading = false;
  var songList = <MusicModel>[].obs;
  var fetched = false.obs;
  final ScrollController scrollController = ScrollController();
  // List

  MusicModel item = MusicModel();

  @override
  void onInit() {
    item = Get.arguments as MusicModel;
    super.onInit();
    _fetchSongs();
    scrollController.addListener(() {
      if (scrollController.position.pixels <=
              scrollController.position.maxScrollExtent &&
          item.type == 'songs' &&
          !loading) {
        page += 1;
        _fetchSongs();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  _fetchSongs() async {
    print("_fetchSongs == ");
    loading = true;
    try {
      switch (item.type) {
        case 'songs':
          break;
        case 'album':
          final result = await SaavnAPI().fetchAlbumSongs(item.id ?? '');
          break;
        case 'playlist':
          final result = await SaavnAPI().fetchPlaylistSongs(item.id ?? '');
          break;
        default:
          fetched.value = true;
          loading = false;
          ShowSnackBar().showSnackBar(
            'Error: Unsupported Type ${item.type}',
            duration: const Duration(seconds: 3),
          );
          break;
      }
    } catch (e) {
      loading = false;
      fetched.value = true;
      Logger.root.severe(
        'Error in song_list with type ${item.type}: $e',
      );
    }
  }
}
