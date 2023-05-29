import 'package:black_hole/custom_widget.dart/custom_physics.dart';
import 'package:black_hole/custom_widget.dart/song_title_trailing_menu.dart';
import 'package:black_hole/gen/assets.gen.dart';
import 'package:black_hole/helpers/image_resolution_modifier.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HorizontalAlbumsListSeparated extends StatelessWidget {
  const HorizontalAlbumsListSeparated({
    super.key,
    required this.songList,
    required this.onTap,
  });

  final List<MusicModel> songList;
  final Function(int) onTap;

  String getSubTitle(MusicModel item) {
    final type = item.type;
    if (type == 'charts') {
      return '';
    } else if (type == 'playlist' || type == 'radio_station') {
      return item.subtitle ?? '';
    } else if (type == 'song') {
      return item.artist ?? '';
    } else {
      if (item.subtitle != null) {
        return item.subtitle ?? '';
      }
      final artists =
          item.moreInfo?.artistMap?.artists?.map((e) => e.name).toList();
      if (artists != null) {
        return artists.join(', ');
      }
      if (item.artist != null) {
        return item.artist ?? '';
      }
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final bool rotated = orientation == Orientation.landscape;
        final portion = (songList.length <= 4) ? 1 : 0.0875;
        final listSize =
            rotated ? Get.width * portion / 2 : Get.width * portion;
        return SizedBox(
          height: songList.length < 4 ? songList.length * 74 : 74,
          child: Align(
            alignment: Alignment.centerLeft,
            child: ListView.builder(
              physics: PagingScrollPhysics(itemDimension: listSize),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemExtent: listSize,
              itemCount: (songList.length / 4).ceil(),
              itemBuilder: (context, index) {
                final itemGroup = songList.skip(index * 4).take(4);
                return SizedBox(
                  height: 74 * 2,
                  width: listSize,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: itemGroup.map((item) {
                      final subtitle = getSubTitle(item);
                      return ListTile(
                        title: Text(
                          item.title ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Card(
                          margin: EdgeInsets.zero,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Assets.images.cover.image(fit: BoxFit.cover),
                            imageUrl: getImageUrl(item.image),
                            placeholder: (context, url) => Image.asset(
                              (item.type == 'playlist' || item.type == 'album')
                                  ? Assets.images.album.path
                                  : item.type == 'artist'
                                      ? Assets.images.artist.path
                                      : Assets.images.cover.path,
                            ),
                          ),
                        ),
                        trailing: SongTitleTrailingMenu(data: item),
                        onTap: () => onTap.call(songList.indexOf(item)),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
