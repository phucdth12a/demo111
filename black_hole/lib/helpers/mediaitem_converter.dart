import 'package:audio_service/audio_service.dart';
import 'package:black_hole/model/music_model.dart';

import 'image_resolution_modifier.dart';

class MediaItemConverter {
  static Map mediaItemToMap(MediaItem mediaItem) {
    return {
      'id': mediaItem.id,
      'album': mediaItem.album.toString(),
      'album_id': mediaItem.extras?['album_id'],
      'artist': mediaItem.artist.toString(),
      'duration': mediaItem.duration?.inSeconds.toString(),
      'genre': mediaItem.genre.toString(),
      'has_lyrics': mediaItem.extras!['has_lyrics'],
      'image': mediaItem.artUri.toString(),
      'language': mediaItem.extras?['language'].toString(),
      'release_date': mediaItem.extras?['release_date'],
      'subtitle': mediaItem.extras?['subtitle'],
      'title': mediaItem.title,
      'url': mediaItem.extras!['url'].toString(),
      'lowUrl': mediaItem.extras!['lowUrl']?.toString(),
      'highUrl': mediaItem.extras!['highUrl']?.toString(),
      'year': mediaItem.extras?['year'].toString(),
      '320kbps': mediaItem.extras?['320kbps'],
      'quality': mediaItem.extras?['quality'],
      'perma_url': mediaItem.extras?['perma_url'],
      'expire_at': mediaItem.extras?['expire_at'],
    };
  }

  static MediaItem mapToMediaItem(
    MusicModel song, {
    bool addedByAutoplay = false,
    bool autoplay = true,
    String? playlistBox,
  }) {
    return MediaItem(
      id: song.id ?? '',
      album: song.album ?? '',
      artist: song.artist ?? '',
      duration: Duration(
        seconds: int.parse(
          (song.duration == null ||
                  song.duration == 'null' ||
                  song.duration == '')
              ? '180'
              : song.duration ?? '',
        ),
      ),
      title: song.title ?? '',
      artUri: Uri.parse(
        getImageUrl(song.image ?? ''),
      ),
      genre: song.language ?? '',
      extras: {
        'url': song.url ?? '',
        'lowUrl': song.lowUrl ?? '',
        'highUrl': song.highUrl ?? '',
        'year': song.year ?? '',
        'language': song.language ?? '',
        '320kbps': song.url320kbps ?? '',
        'quality': song.quality ?? '',
        'has_lyrics': song.hasLyrics ?? '',
        'release_date': song.releaseDate ?? '',
        'album_id': song.albumId ?? '',
        'subtitle': song.subtitle ?? '',
        'perma_url': song.permaUrl ?? '',
        'expire_at': song.expireAt ?? '',
        'addedByAutoplay': addedByAutoplay,
        'autoplay': autoplay,
        'playlistBox': playlistBox,
      },
    );
  }

  static MediaItem downloadMapToMediaItem(MusicModel song) {
    return MediaItem(
      id: song.id ?? '',
      album: song.album ?? '',
      artist: song.artist ?? '',
      duration: Duration(
        seconds: int.parse(
          (song.duration == null ||
                  song.duration == 'null' ||
                  song.duration == '')
              ? '180'
              : song.duration ?? '',
        ),
      ),
      title: song.title ?? '',
      artUri: Uri.file(song.image ?? ''.toString()),
      genre: song.genre ?? '',
      extras: {
        'url': song.path ?? '',
        'year': song.year ?? '',
        'language': song.genre ?? '',
        'release_date': song.releaseDate ?? '',
        'album_id': song.albumId ?? '',
        'subtitle': song.subtitle ?? '',
        'quality': song.quality ?? '',
      },
    );
  }
}
