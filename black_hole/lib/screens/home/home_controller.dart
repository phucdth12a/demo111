import 'dart:convert';

import 'package:black_hole/api/api.dart';
import 'package:black_hole/custom_widget.dart/textinput_dialog.dart';
import 'package:black_hole/helpers/supabase.dart';
import 'package:black_hole/model/home_page_model.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  var name =
      (Hive.box('settings').get('name', defaultValue: 'Guest') as String).obs;
  var lists = <String>[].obs;
  var data = HomePageModel().obs;

  var recentList = <MusicModel>[].obs;

  var likedArtists =
      (Hive.box('cache').get('likedArtists', defaultValue: {}) as Map).obs;
  var blacklistedHomeSections = (Hive.box('settings')
          .get('blacklistedHomeSections', defaultValue: []) as List)
      .obs;
  var playlistNames =
      (Hive.box('settings').get('playlistNames', defaultValue: []) as List? ??
              ['Favotite Songs'])
          .obs;

  bool checked = false;

  final scrollController = ScrollController();

  bool fetched = false;

  var recentIndex = 0.obs;
  var playlistIndex = 1.obs;

  @override
  void onInit() {
    fetchHomePageData();
    super.onInit();
    lists.value = ['recent', 'playlist'];
    String cachedData = Hive.box('cache').get('homepage', defaultValue: '');
    if (cachedData.isNotEmpty) {
      data.value = HomePageModel.fromJson(jsonDecode(cachedData));
    }
    String cacheRecentList =
        Hive.box('cache').get('recentSongs', defaultValue: '');
    if (cacheRecentList.isNotEmpty) {
// recentList.value = jsonDecode(cacheRecentList) as Map<String, dynamic>
    }

    if (playlistNames.length < 3) {
      recentIndex.value = 1;
      playlistIndex.value = 0;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  fetchHomePageData() async {
    final result = await SaavnAPI().fetchHomePageData();
    if (result != null) {
      Hive.box('cache').put('homepage', jsonEncode(result.toJson()));
      lists.addAll(result.modules.map((e) => e.id).toList());
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }

    print("lists == $lists ===");
  }

  showTextInputDialogAction() async {
    await showTextInputDialog(
      title: 'Name',
      initialtext: name.value,
      keyboardType: TextInputType.name,
      onSubmitted: (value) {
        Get.back();
        Hive.box('settings').put('name', value);
        name.value = value;
        updateUserDetails('name', value);
      },
    );
  }

  updateUserDetails(String key, dynamic value) {
    final userId = Hive.box('settings').get('userId') as String?;
    SupaBase().updateUserDeatails(userId, key, value);
  }

  goSearchAction() {}
}