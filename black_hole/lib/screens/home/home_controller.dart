import 'dart:convert';

import 'package:black_hole/api/api.dart';
import 'package:black_hole/custom_widget.dart/snackbar.dart';
import 'package:black_hole/custom_widget.dart/textinput_dialog.dart';
import 'package:black_hole/helpers/supabase.dart';
import 'package:black_hole/model/home_page_model.dart';
import 'package:black_hole/model/modules_model.dart';
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
  var likedRadio = <MusicModel>[].obs;

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

    String likedRadioData =
        Hive.box('settings').get('likedRadio', defaultValue: '');
    if (likedRadioData.isNotEmpty) {
      likedRadio.value = (jsonDecode(likedRadioData) as List<dynamic>)
          .map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList();
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
      data.value = result;
      Hive.box('cache').put('homepage', jsonEncode(result.toJson()));
      lists.addAll(result.modules.map((e) => e.id).toList());
      lists.insert((lists.length / 2).round(), 'likedArtists');
    }
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

  ModulesModel? getModules(int index) {
    return data.value.modules
        .firstWhereOrNull((element) => element.id == lists[index])
        ?.data;
  }

  List<MusicModel> getListData(int index) {
    return data.value.page
            .firstWhereOrNull((element) => element.id == lists[index])
            ?.data ??
        [];
  }

  toggleLikeRatio(MusicModel item) {
    likedRadio.contains(item) ? likedRadio.remove(item) : likedRadio.add(item);
    Hive.box('settings').put(
      'likedRadio',
      jsonEncode(
        likedRadio
            .map(
              (element) => element.toJson(),
            )
            .toList(),
      ),
    );
  }

  onTapItem(MusicModel item) async {
    if (item.type == 'radio_station') {
      ShowSnackBar().showSnackBar(
        'connectingRadio'.tr,
        duration: const Duration(seconds: 2),
      );
      final featuredStationType = item.moreInfo?.featuredStationType ?? '';
      String? result = await SaavnAPI().createRadio(
        names: featuredStationType == 'artist'
            ? [item.moreInfo?.query ?? '']
            : [item.id ?? ''],
        stationType: featuredStationType,
      );
      if (result != null) {
        SaavnAPI().getRadioSongs(stationId: result);
      }
    }
  }
}
