import 'dart:io';

import 'package:black_hole/custom_widget.dart/custom_physics.dart';
import 'package:black_hole/custom_widget.dart/gradient_containers.dart';
import 'package:black_hole/gen/assets.gen.dart';
import 'package:black_hole/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'root_controller.dart';

class RootScreen extends GetView<RootController> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool rotated = orientation == Orientation.landscape;
        return GradientContainer(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            drawer: Drawer(
              child: GradientContainer(
                child: CustomScrollView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      stretch: true,
                      expandedHeight: Get.height * 0.2,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Obx(
                          () => RichText(
                            text: TextSpan(
                              text: 'appTitle'.tr,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                              children: [
                                TextSpan(
                                  text: controller.appVersion.isEmpty
                                      ? ''
                                      : '\nv${controller.appVersion.value}',
                                  style: const TextStyle(fontSize: 7),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        titlePadding: const EdgeInsets.only(bottom: 40),
                        centerTitle: true,
                        background: ShaderMask(
                          shaderCallback: (rect) {
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.1),
                              ],
                            ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: Image.asset(
                            Theme.of(context).brightness == Brightness.dark
                                ? Assets.images.headerDark.path
                                : Assets.images.header.path,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ListTile(
                            title: Text(
                              'home'.tr,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(Icons.home_rounded,
                                color: Theme.of(context).colorScheme.secondary),
                            selected: true,
                            onTap: () => Get.back(),
                          ),
                          if (Platform.isAndroid)
                            ListTile(
                              title: Text('myMusic'.tr),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              leading: Icon(MdiIcons.folderMusic,
                                  color: Theme.of(context).iconTheme.color),
                              onTap: controller.goFolderMusicAction,
                            ),
                          ListTile(
                            title: Text('downs'.tr),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              Icons.download_done_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: controller.goDownloadAction,
                          ),
                          ListTile(
                            title: Text('playlists'.tr),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              Icons.playlist_play_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: controller.goPlayListAction,
                          ),
                          ListTile(
                            title: const Text('settings'),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              Icons.settings_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: controller.goSettingsAction,
                          ),
                          ListTile(
                            title: Text('about'.tr),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              Icons.info_outline_rounded,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onTap: controller.goAboutAction,
                          ),
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children: [
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                            child: Center(
                              child: Text(
                                'madeBy'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: WillPopScope(
              onWillPop: controller.handleWillPop,
              child: SafeArea(
                child: Row(
                  children: [
                    if (rotated)
                      Obx(
                        () => NavigationRail(
                          minWidth: 70,
                          groupAlignment: 0,
                          backgroundColor: Theme.of(context).cardColor,
                          selectedIndex: controller.selectedIndex.value,
                          onDestinationSelected: (index) =>
                              controller.onItemTapped(index),
                          labelType: Get.width > 1050
                              ? NavigationRailLabelType.selected
                              : NavigationRailLabelType.none,
                          selectedLabelTextStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                          unselectedLabelTextStyle: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                          ),
                          selectedIconTheme: Theme.of(context)
                              .iconTheme
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          unselectedIconTheme: Theme.of(context).iconTheme,
                          useIndicator: Get.width < 1050,
                          indicatorColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withOpacity(0.2),
                          leading: Get.width > 1050
                              ? null
                              : Builder(
                                  builder: (context) => Transform.rotate(
                                    angle: 22 / 7 * 2,
                                    child: IconButton(
                                      onPressed: () {
                                        Scaffold.of(context).openDrawer();
                                      },
                                      icon: const Icon(
                                          Icons.horizontal_split_rounded),
                                      tooltip: 'openAppDrawerTooltip'.tr,
                                    ),
                                  ),
                                ),
                          destinations: [
                            NavigationRailDestination(
                              icon: const Icon(Icons.home_rounded),
                              label: Text('home'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.trending_up_rounded),
                              label: Text('topCharts'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(MdiIcons.youtube),
                              label: Text('youTube'.tr),
                            ),
                            NavigationRailDestination(
                              icon: const Icon(Icons.my_library_music_rounded),
                              label: Text('library'.tr),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView(
                              physics: const CustomPhysics(),
                              onPageChanged: (index) {
                                controller.selectedIndex.value = index;
                              },
                              controller: controller.pageController,
                              children: [
                                HomeScreen(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: rotated
                ? null
                : SafeArea(
                    child: Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 60,
                        child: SalomonBottomBar(
                          currentIndex: controller.selectedIndex.value,
                          onTap: (index) => controller.onItemTapped(index),
                          items: [
                            SalomonBottomBarItem(
                              icon: const Icon(Icons.home_rounded),
                              title: Text('home'.tr),
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            if (controller.sectionsToShow
                                .contains('Top Charts'))
                              SalomonBottomBarItem(
                                icon: const Icon(Icons.trending_up_rounded),
                                title: Text('topCharts'.tr),
                                selectedColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            SalomonBottomBarItem(
                              icon: const Icon(MdiIcons.youtube),
                              title: Text('youTube'.tr),
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            SalomonBottomBarItem(
                              icon: const Icon(Icons.my_library_music_rounded),
                              title: Text('library'.tr),
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            if (controller.sectionsToShow.contains('Settings'))
                              SalomonBottomBarItem(
                                icon: const Icon(Icons.settings_rounded),
                                title: Text('settings'.tr),
                                selectedColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
