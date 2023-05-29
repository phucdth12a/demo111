import 'package:audio_service/audio_service.dart';
import 'package:black_hole/custom_widget.dart/snackbar.dart';
import 'package:black_hole/helpers/playlist.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.item,
    this.size,
    this.showSnack = false,
    this.mediaItem,
  });

  final MusicModel? item;
  final double? size;
  final bool showSnack;
  final MediaItem? mediaItem;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton>
    with SingleTickerProviderStateMixin {
  bool liked = false;
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _scale = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(_curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      liked = checkPlaylist(
          'Favorite Songs', widget.mediaItem?.id ?? widget.item?.id ?? '');
    } catch (e) {
      Logger.root.severe('Error in likeButton: $e');
    }
    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        icon: Icon(
          liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: liked ? Colors.redAccent : Theme.of(context).iconTheme.color,
        ),
        iconSize: widget.size ?? 24,
        tooltip: liked ? 'unlike'.tr : 'like'.tr,
        onPressed: () {
          liked
              ? removeLiked(widget.mediaItem?.id ?? widget.item?.id ?? '')
              : widget.mediaItem == null
                  ? addMapToPlaylist('Favorite Songs', widget.item!)
                  : addItemToPlaylist('Favorite Songs', widget.mediaItem!);
          if (!liked) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
          if (widget.showSnack) {
            ShowSnackBar().showSnackBar(
              liked ? 'addedToFav'.tr : 'removedFromFav'.tr,
              action: SnackBarAction(
                textColor: Theme.of(context).colorScheme.secondary,
                label: 'undo'.tr,
                onPressed: () {
                  liked
                      ? removeLiked(
                          widget.mediaItem?.id ?? widget.item?.id ?? '')
                      : widget.mediaItem == null
                          ? addMapToPlaylist('Favorite Songs', widget.item!)
                          : addItemToPlaylist(
                              'Favorite Songs', widget.mediaItem!);
                  liked = !liked;
                  setState(() {});
                },
              ),
            );
          }
        },
      ),
    );
  }
}
