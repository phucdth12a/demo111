import 'dart:math';
import 'package:black_hole/custom_widget.dart/horizontal_albumlist_separated.dart';
import 'package:black_hole/screens/home/home_controller.dart';
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
                return contentData(context, max(index - 2, 0));
              },
            ),
    );
  }

  Widget checkVersion() {
    return const SizedBox.shrink();
    // if (!controller.checked && Platform)
  }

  Widget contentData(BuildContext context, int index) {
    // return (controller.blacklistedHomeSections.contains(element)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
          child: Text(
            controller.lists[index].toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
