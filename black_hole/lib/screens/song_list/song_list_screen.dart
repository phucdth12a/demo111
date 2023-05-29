import 'package:black_hole/custom_widget.dart/bouncy_playlist_header_scroll_view.dart';
import 'package:black_hole/custom_widget.dart/gradient_containers.dart';
import 'package:black_hole/screens/song_list/song_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SongListScreen extends GetView<SongListController> {
  const SongListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Obx(
                () => !controller.fetched.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : BouncyPlaylistHeaderScrollView(
                        scrollController: controller.scrollController,
                        actions: [
                          if (controller.songList.isNotEmpty) 
                            
                        ],
                        sliverList: sliverList,
                        shrinkWrap: shrinkWrap,
                        title: title,
                        localImage: localImage,
                        placeholderImage: placeholderImage,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
