import 'dart:async';

import 'package:flame/extensions.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shopink/ui/home/home_screen.dart';

import 'component/root_menu.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopink',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.02),
            ),
            child: const Icon(Icons.menu),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.02),
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const HomeScreen(),
                // Container(
                //   child: Center(
                //     child: StickerData(
                //       size: 100,
                //     ),
                //   ),
                // ),
                Container(
                  color: Colors.green,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RootMenu(
              currentIndex: _selectedIndex,
              tappedCallBack: (value) {
                _selectedIndex = value;
                pageController.jumpToPage(value);
                // pageController.animateToPage(
                //   value,
                //   duration: const Duration(milliseconds: 200),
                //   curve: Curves.easeInOut,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StickerData extends StatefulWidget {
  const StickerData({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  State<StickerData> createState() => _StickerDataState();
}

class _StickerDataState extends State<StickerData> {
  SpriteAnimation? animation;

  @override
  void initState() {
    super.initState();
    loadSticker();
  }

  @override
  void didUpdateWidget(covariant StickerData oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadSticker();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: animation != null
          ? SpriteAnimationWidget(
              animation: animation!,
              playing: true,
              anchor: Anchor.center,
            )
          : null,
    );
  }

  Future<ImageInfo> getImage(String path) async {
    Completer<ImageInfo> completer = Completer();
    NetworkImage(path)
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    return completer.future;
  }

  loadSticker() async {
    _loadSticker(
      url:
          'https://cdn.piepme.com/17931/images/piep-KhfbSRDQ16844882868561684488286856.png',
      fps: 24,
      frames: 24,
    );
  }

  _loadSticker({String? url, int? fps, int? frames}) async {
    final imageInfo = await getImage(url ?? '');
    final image = imageInfo.image;
    final animationData = SpriteAnimationData.sequenced(
      amount: fps ?? 1,
      stepTime: 0.075,
      textureSize: Vector2.all(200),
    );
    if (mounted) {
      setState(() {
        animation = SpriteAnimation.fromFrameData(image, animationData);
      });
    }
  }

  // 0.075
}
