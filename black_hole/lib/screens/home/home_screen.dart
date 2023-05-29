import 'dart:io';
import 'dart:math';
import 'package:black_hole/custom_widget.dart/horizontal_albumlist_separated.dart';
import 'package:black_hole/custom_widget.dart/like_button.dart';
import 'package:black_hole/custom_widget.dart/on_hover.dart';
import 'package:black_hole/custom_widget.dart/song_title_trailing_menu.dart';
import 'package:black_hole/gen/assets.gen.dart';
import 'package:black_hole/helpers/extensions.dart';
import 'package:black_hole/helpers/image_resolution_modifier.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:black_hole/screens/home/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return OrientationBuilder(
      builder: (context, orientation) {
        bool rotated = orientation == Orientation.landscape;
        return Stack(
          children: [
            checkVersion(),
            NestedScrollView(
              physics: const BouncingScrollPhysics(),
              controller: controller.scrollController,
              headerSliverBuilder: (context, innerBoxScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 135,
                    backgroundColor: Colors.transparent,
                    toolbarHeight: 65,
                    automaticallyImplyLeading: false,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        return FlexibleSpaceBar(
                          background: GestureDetector(
                            onTap: controller.showTextInputDialogAction,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 60),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Text(
                                        'homeGreet'.tr,
                                        style: TextStyle(
                                          letterSpacing: 2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Obx(
                                        () => Text(
                                          controller.name.isEmpty
                                              ? 'Guest'
                                              : controller.name.value,
                                          style: const TextStyle(
                                            letterSpacing: 2,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    stretch: true,
                    toolbarHeight: 65,
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedBuilder(
                        animation: controller.scrollController,
                        builder: (context, child) {
                          return GestureDetector(
                            onTap: controller.goSearchAction,
                            child: AnimatedContainer(
                              width: (!controller.scrollController.hasClients ||
                                      controller.scrollController.positions
                                              .length >
                                          1)
                                  ? Get.width
                                  : max(
                                      Get.width -
                                          controller.scrollController.offset
                                              .roundToDouble(),
                                      Get.width - 75,
                                    ),
                              height: 55,
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).cardColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5,
                                    offset: Offset(1.5, 1.5),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Icon(
                                    CupertinoIcons.search,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'searchText'.tr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .color,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ];
              },
              body: contentHome(context),
            ),
            if (!rotated)
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 4),
                child: Transform.rotate(
                  angle: 22 / 7 * 2,
                  child: IconButton(
                    icon: const Icon(Icons.horizontal_split_rounded),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    tooltip: 'openAppDrawerTooltip'.tr,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget contentHome(BuildContext context) {
    double boxSize = Get.height > Get.width ? Get.width / 2 : Get.height / 2.5;
    if (boxSize > 250) boxSize = 250;
    return Obx(
      () => (controller.data.value.greeting == null && controller.lists.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemCount: controller.data.value.greeting == null
                  ? 2
                  : controller.lists.length,
              itemBuilder: (context, index) {
                if (index == controller.recentIndex.value) {
                  return (controller.recentList.isEmpty ||
                          !(Hive.box('settings')
                              .get('showRecent', defaultValue: true) as bool))
                      ? const SizedBox()
                      : Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 0, 5),
                                  child: Text(
                                    'lastSession'.tr,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            HorizontalAlbumsListSeparated(
                                songList: controller.recentList,
                                onTap: (index) {}),
                          ],
                        );
                }
                if (index == controller.playlistIndex.value) {
                  return SizedBox();
                }
                if (controller.lists[index] == 'likedArtists') {
                  return SizedBox();
                }
                return contentData(context, index, boxSize);
              },
            ),
    );
  }

  Widget checkVersion() {
    return const SizedBox.shrink();
    // if (!controller.checked && Platform)
  }

  Widget contentData(BuildContext context, int index, double boxSize) {
    // return (controller.blacklistedHomeSections.contains(element)
    final listData = controller.getListData(index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
          child: Text(
            controller.getModules(index)?.title ?? '',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: boxSize + 15,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: listData.length,
            itemBuilder: (context, index) =>
                widgetItem(context, listData[index], boxSize, listData),
          ),
        ),
      ],
    );
  }

  Widget widgetItem(BuildContext context, MusicModel item, double boxSize,
      List<MusicModel> list) {
    return GestureDetector(
      onLongPress: () => showLongPress(context, item, boxSize),
      onTap: () => controller.onTapItem(item, list),
      child: SizedBox(
        width: boxSize - 30,
        child: HoverBox(
          builder: (context, isHover, child) {
            return Card(
              color: isHover ? null : Colors.transparent,
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox.square(
                        dimension: isHover ? boxSize - 25 : boxSize - 30,
                        child: child,
                      ),
                      if (isHover &&
                          ['song', 'radio_station'].contains(item.type))
                        Positioned.fill(
                          child: Container(
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(
                                item.type == 'radio_station' ? 1000 : 10,
                              ),
                            ),
                            child: Center(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(10000),
                                ),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (item.type == 'radio_station' &&
                          (Platform.isAndroid || Platform.isIOS || isHover))
                        Align(
                          alignment: Alignment.topRight,
                          child: Obx(
                            () => IconButton(
                              icon: controller.likedRadio
                                      .map((e) => e.id)
                                      .contains(item.id)
                                  ? const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_rounded,
                                    ),
                              tooltip: controller.likedRadio.contains(item)
                                  ? 'unlike'.tr
                                  : 'like'.tr,
                              onPressed: () => controller.toggleLikeRatio(item),
                            ),
                          ),
                        ),
                      if (item.type == 'song' || item.duration != null)
                        Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isHover) LikeButton(item: item),
                              SongTitleTrailingMenu(data: item),
                            ],
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text(
                          item.title?.unescape() ?? '',
                          textAlign: TextAlign.center,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        if ((item.subtitle ?? '').isNotEmpty)
                          Text(
                            item.subtitle ??
                                (item.moreInfo?.artistMap?.artists ?? [])
                                    .map((e) => e.name)
                                    .toList()
                                    .join(', '),
                            textAlign: TextAlign.center,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color:
                                  Theme.of(context).textTheme.bodySmall!.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                item.type == 'radio_station' ? 1000 : 10,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              errorWidget: (context, url, error) =>
                  Assets.images.cover.image(fit: BoxFit.cover),
              imageUrl: getImageUrl(item.image),
              placeholder: (context, url) => Image.asset(
                ['playlist', 'album'].contains(item.type)
                    ? Assets.images.album.path
                    : item.type == 'artist'
                        ? Assets.images.artist.path
                        : Assets.images.cover.path,
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLongPress(BuildContext context, MusicModel item, double boxSize) {
    Feedback.forLongPress(context);
    showDialog(
      context: context,
      builder: (context) {
        return InteractiveViewer(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
              ),
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                content: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        item.type == 'radio_section' ? 1000 : 15),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) =>
                        Assets.images.cover.image(),
                    imageUrl: getImageUrl(item.image),
                    placeholder: (context, url) => Image.asset(
                      ['playlist', 'album'].contains(item.type)
                          ? Assets.images.album.path
                          : item.type == 'artist'
                              ? Assets.images.artist.path
                              : Assets.images.cover.path,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
