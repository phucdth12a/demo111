import 'package:black_hole/model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class SongTitleTrailingMenu extends StatelessWidget {
  const SongTitleTrailingMenu({
    super.key,
    required this.data,
    this.isPlayList = false,
    this.deleteLiked,
  });

  final MusicModel data;
  final bool isPlayList;
  final Function(MusicModel)? deleteLiked;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert_rounded,
        color: Theme.of(context).iconTheme.color,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      itemBuilder: (context) => [
        if (isPlayList && deleteLiked != null)
          PopupMenuItem(
            value: 6,
            child: Row(
              children: [
                const Icon(Icons.delete_rounded),
                const SizedBox(width: 10),
                Text('remove'.tr),
              ],
            ),
          ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.playlist_play_rounded,
                color: Theme.of(context).iconTheme.color,
                size: 26,
              ),
              const SizedBox(width: 10),
              Text('playNext'.tr),
            ],
          ),
        ),
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              Icon(
                Icons.playlist_add_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10),
              Text('addToPlayList'.tr),
            ],
          ),
        ),
        PopupMenuItem(
          value: 4,
          child: Row(
            children: [
              Icon(
                Icons.album_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10),
              Text('viewAlbum'.tr),
            ],
          ),
        ),
        if (data.artist != null)
          ...data.artist!.split(', ').map(
                (artist) => PopupMenuItem(
                  value: artist,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 10),
                        Text('${'viewArtist'.tr} ($artist)'),
                      ],
                    ),
                  ),
                ),
              ),
        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.share_rounded,
                color: Theme.of(context).iconTheme.color,
              ),
              const SizedBox(width: 10),
              Text('share'.tr),
            ],
          ),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 3:
            Share.share(data.permaUrl ?? '');
            break;
          case 4:
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     opaque: false,
            //     pageBuilder: (_, __, ___) => SongsListPage(
            //       listItem: {
            //         'type': 'album',
            //         'id': mediaItem.extras?['album_id'],
            //         'title': mediaItem.album,
            //         'image': mediaItem.artUri,
            //       },
            //     ),
            //   ),
            // );
            break;
          case 6:
            deleteLiked?.call(data);
            break;
          case 0:
            // AddToPlaylist().addToPlaylist(context, mediaItem);
            break;
          case 1:
            // addToNowPlaying(context: context, mediaItem: mediaItem);
            break;
          case 2:
            // playNext(mediaItem, context);
            break;
          default:
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     opaque: false,
            //     pageBuilder: (_, __, ___) => AlbumSearchPage(
            //       query: value.toString(),
            //       type: 'Artists',
            //     ),
            //   ),
            // );
            break;
        }
      },
    );
  }
}
