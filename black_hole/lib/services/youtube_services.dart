import 'dart:convert';
import 'dart:io';

import 'package:black_hole/model/music_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:logging/logging.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeServices {
  static const String searchAuthority = 'www.youtube.com';
  static const Map paths = {
    'search': '/search',
    'channel': '/channel',
    'music': '/music',
    'playlis': '/playlist',
  };
  static const Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; rv:96.0) Gecko/20100101 Firefox/96.0'
  };
  final YoutubeExplode yt = YoutubeExplode();

  Future<List<Video>> getPlaylistSongs(String id) async {
    final List<Video> result = await yt.playlists.getVideos(id).toList();
    return result;
  }

  Future<Video?> getVideoFromId(String id) async {
    try {
      final Video result = await yt.videos.get(id);
      return result;
    } catch (e) {
      Logger.root.severe('Error while getting video from id: ', e);
      return null;
    }
  }

  Future<MusicModel?> formatVideoFromId(
      {required String id, Map? data, bool? getUrl}) async {
    final Video? vid = await getVideoFromId(id);
    if (vid == null) {
      return null;
    }
    final MusicModel? response = await formatVideo(
      video: vid,
      quality:
          Hive.box('settings').get('ytQuality', defaultValue: 'Low').toString(),
      data: data,
      getUrl: getUrl ?? true,
    );
    return response;
  }

  Future<MusicModel?> refreshLink(String id) async {
    final Video? res = await getVideoFromId(id);
    if (res == null) {
      return null;
    }
    String quality = 'Low';
    try {
      quality = Hive.box('settings').get('quality', defaultValue: 'Low');
    } catch (_) {}

    final data = await formatVideo(video: res, quality: quality);
    return data;
  }

  Future<Playlist> getPlaylistDetails(String id) async {
    final Playlist metadata = await yt.playlists.get(id);
    return metadata;
  }

  Future<Map<String, List>> getMusicHome() async {
    final Uri link = Uri.https(
      searchAuthority,
      paths['music'].toString(),
    );
    try {
      final Response response = await get(link);
      if (response.statusCode != 200) {
        return {};
      }
      final String searchResults =
          RegExp(r'(\"contents\":{.*?}),\"metadata\"', dotAll: true)
              .firstMatch(response.body)![1]!;
      final Map data = json.decode('{$searchResults}') as Map;

      final List result = data['contents']['twoColumnBrowseResultsRenderer']
              ['tabs'][0]['tabRenderer']['content']['sectionListRenderer']
          ['contents'] as List;

      final List headResult = data['header']['carouselHeaderRenderer']
          ['contents'][0]['carouselItemRenderer']['carouselItems'] as List;

      final List shelfRenderer = result.map((element) {
        return element['itemSectionRenderer']['contents'][0]['shelfRenderer'];
      }).toList();

      final List finalResult = shelfRenderer.map((element) {
        final playlistItems = element['title']['runs'][0]['text'].trim() ==
                    'Charts' ||
                element['title']['runs'][0]['text'].trim() == 'Classements'
            ? formatChartItems(
                element['content']['horizontalListRenderer']['items'] as List,
              )
            : element['title']['runs'][0]['text']
                        .toString()
                        .contains('Music Videos') ||
                    element['title']['runs'][0]['text']
                        .toString()
                        .contains('Nouveaux clips') ||
                    element['title']['runs'][0]['text']
                        .toString()
                        .contains('En Musique Avec Moi') ||
                    element['title']['runs'][0]['text']
                        .toString()
                        .contains('Performances Uniques')
                ? formatVideoItems(
                    element['content']['horizontalListRenderer']['items']
                        as List,
                  )
                : formatItems(
                    element['content']['horizontalListRenderer']['items']
                        as List,
                  );
        if (playlistItems.isNotEmpty) {
          return {
            'title': element['title']['runs'][0]['text'],
            'playlists': playlistItems,
          };
        } else {
          Logger.root.severe(
            "got null in getMusicHome for '${element['title']['runs'][0]['text']}'",
          );
          return null;
        }
      }).toList();

      final List finalHeadResult = formatHeadItems(headResult);
      finalResult.removeWhere((element) => element == null);

      return {'body': finalResult, 'head': finalHeadResult};
    } catch (e) {
      Logger.root.severe('Error in getMusicHome: $e');
      return {};
    }
  }

  Future<List> getSearchSuggestions({required String query}) async {
    const baseUrl =
        // 'https://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=';
        'https://invidious.snopyta.org/api/v1/search/suggestions?q=';
    final Uri link = Uri.parse(baseUrl + query);
    try {
      final Response response = await get(link, headers: headers);
      if (response.statusCode != 200) {
        return [];
      }
      final Map res = jsonDecode(response.body) as Map;
      return res['suggestions'] as List;
    } catch (e) {
      Logger.root.severe('Error in getSearchSuggestions: $e');
      return [];
    }
  }

  List formatVideoItems(List itemsList) {
    try {
      final List result = itemsList.map((e) {
        return {
          'title': e['gridVideoRenderer']['title']['simpleText'],
          'type': 'video',
          'description': e['gridVideoRenderer']['shortBylineText']['runs'][0]
              ['text'],
          'count': e['gridVideoRenderer']['shortViewCountText']['simpleText'],
          'videoId': e['gridVideoRenderer']['videoId'],
          'firstItemId': e['gridVideoRenderer']['videoId'],
          'image':
              e['gridVideoRenderer']['thumbnail']['thumbnails'].last['url'],
          'imageMin': e['gridVideoRenderer']['thumbnail']['thumbnails'][0]
              ['url'],
          'imageMedium': e['gridVideoRenderer']['thumbnail']['thumbnails'][1]
              ['url'],
          'imageStandard': e['gridVideoRenderer']['thumbnail']['thumbnails'][2]
              ['url'],
          'imageMax':
              e['gridVideoRenderer']['thumbnail']['thumbnails'].last['url'],
        };
      }).toList();

      return result;
    } catch (e) {
      Logger.root.severe('Error in formatVideoItems: $e');
      return List.empty();
    }
  }

  List formatChartItems(List itemsList) {
    try {
      final List result = itemsList.map((e) {
        return {
          'title': e['gridPlaylistRenderer']['title']['runs'][0]['text'],
          'type': 'chart',
          'description': e['gridPlaylistRenderer']['shortBylineText']['runs'][0]
              ['text'],
          'count': e['gridPlaylistRenderer']['videoCountText']['runs'][0]
              ['text'],
          'playlistId': e['gridPlaylistRenderer']['navigationEndpoint']
              ['watchEndpoint']['playlistId'],
          'firstItemId': e['gridPlaylistRenderer']['navigationEndpoint']
              ['watchEndpoint']['videoId'],
          'image': e['gridPlaylistRenderer']['thumbnail']['thumbnails'][0]
              ['url'],
          'imageMedium': e['gridPlaylistRenderer']['thumbnail']['thumbnails'][0]
              ['url'],
          'imageStandard': e['gridPlaylistRenderer']['thumbnail']['thumbnails']
              [0]['url'],
          'imageMax': e['gridPlaylistRenderer']['thumbnail']['thumbnails'][0]
              ['url'],
        };
      }).toList();

      return result;
    } catch (e) {
      Logger.root.severe('Error in formatChartItems: $e');
      return List.empty();
    }
  }

  List formatItems(List itemsList) {
    try {
      final List result = itemsList.map((e) {
        return {
          'title': e['compactStationRenderer']['title']['simpleText'],
          'type': 'playlist',
          'description': e['compactStationRenderer']['description']
              ['simpleText'],
          'count': e['compactStationRenderer']['videoCountText']['runs'][0]
              ['text'],
          'playlistId': e['compactStationRenderer']['navigationEndpoint']
              ['watchEndpoint']['playlistId'],
          'firstItemId': e['compactStationRenderer']['navigationEndpoint']
              ['watchEndpoint']['videoId'],
          'image': e['compactStationRenderer']['thumbnail']['thumbnails'][0]
              ['url'],
          'imageMedium': e['compactStationRenderer']['thumbnail']['thumbnails']
              [0]['url'],
          'imageStandard': e['compactStationRenderer']['thumbnail']
              ['thumbnails'][1]['url'],
          'imageMax': e['compactStationRenderer']['thumbnail']['thumbnails'][2]
              ['url'],
        };
      }).toList();

      return result;
    } catch (e) {
      Logger.root.severe('Error in formatItems: $e');
      return List.empty();
    }
  }

  List formatHeadItems(List itemsList) {
    try {
      final List result = itemsList.map((e) {
        return {
          'title': e['defaultPromoPanelRenderer']['title']['runs'][0]['text'],
          'type': 'video',
          'description':
              (e['defaultPromoPanelRenderer']['description']['runs'] as List)
                  .map((e) => e['text'])
                  .toList()
                  .join(),
          'videoId': e['defaultPromoPanelRenderer']['navigationEndpoint']
              ['watchEndpoint']['videoId'],
          'firstItemId': e['defaultPromoPanelRenderer']['navigationEndpoint']
              ['watchEndpoint']['videoId'],
          'image': e['defaultPromoPanelRenderer']
                          ['largeFormFactorBackgroundThumbnail']
                      ['thumbnailLandscapePortraitRenderer']['landscape']
                  ['thumbnails']
              .last['url'],
          'imageMedium': e['defaultPromoPanelRenderer']
                      ['largeFormFactorBackgroundThumbnail']
                  ['thumbnailLandscapePortraitRenderer']['landscape']
              ['thumbnails'][1]['url'],
          'imageStandard': e['defaultPromoPanelRenderer']
                      ['largeFormFactorBackgroundThumbnail']
                  ['thumbnailLandscapePortraitRenderer']['landscape']
              ['thumbnails'][2]['url'],
          'imageMax': e['defaultPromoPanelRenderer']
                          ['largeFormFactorBackgroundThumbnail']
                      ['thumbnailLandscapePortraitRenderer']['landscape']
                  ['thumbnails']
              .last['url'],
        };
      }).toList();

      return result;
    } catch (e) {
      Logger.root.severe('Error in formatHeadItems: $e');
      return List.empty();
    }
  }

  Future<MusicModel?> formatVideo(
      {required Video video,
      required String quality,
      Map? data,
      bool getUrl = true}) async {
    if (video.duration?.inSeconds == null) return null;
    List<String> urls = [];
    String finalUrl = '';
    String expireAt = '0';
    if (getUrl) {
      if (Hive.box('ytlinkcache').containsKey(video.id.value)) {
        final Map cacheData = Hive.box('ytlinkcache').get(video.id.value);
        final int cachedExporeAt = int.parse(cacheData['expire_at'].toString());
        if ((DateTime.now().millisecondsSinceEpoch ~/ 1000) + 350 >
            cachedExporeAt) {
          urls = await getUri(video);
        } else {
          Logger.root.info('cache found for ${video.id.value}');
          urls = [
            cacheData['lowUrl'].toString(),
            cacheData['hightUrl'].toString()
          ];
        }
      } else {
        urls = await getUri(video);
      }
      finalUrl = quality == 'high' ? urls.last : urls.first;
      expireAt = RegExp('expire=(.*?)&').firstMatch(finalUrl)!.group(1) ??
          (DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600 * 5.5)
              .toString();

      try {
        await Hive.box('ytlinkcache').put(video.id.value, {
          'url': finalUrl,
          'expire_at': expireAt,
          'lowUrl': urls.first,
          'hightUrl': urls.last,
        }).onError(
          (error, stackTrace) => Logger.root.severe(
              'Hive Error in formatVideo, you probably forgot to open box.\nError: $error'),
        );
      } catch (e) {
        Logger.root.severe(
          'Hive Error in formatVideo, you probably forgot to open box.\nError: $e',
        );
      }
    }

    return MusicModel(
      id: video.id.value,
      album: (data?['album'] ?? '') != ''
          ? data!['album']
          : video.author.replaceAll('- Topic', '').trim(),
      duration: video.duration?.inSeconds.toString(),
      title: (data?['title'] ?? '') != '' ? data!['title'] : video.title.trim(),
      artist: (data?['artist'] ?? '') != ''
          ? data!['artist']
          : video.author.replaceAll('- Topic', '').trim(),
      image: video.thumbnails.maxResUrl,
      secondImage: video.thumbnails.highResUrl,
      language: 'YouTube',
      genre: 'YouTube',
      expireAt: expireAt,
      url: finalUrl,
      lowUrl: urls.isNotEmpty ? urls.first : '',
      highUrl: urls.isNotEmpty ? urls.last : '',
      year: video.uploadDate?.year.toString(),
      url320kbps: 'false',
      hasLyrics: 'false',
      releaseDate: video.publishDate.toString(),
      albumId: video.channelId.value,
      subtitle:
          (data?['subtitle'] ?? '') != '' ? data!['subtitle'] : video.author,
      permaUrl: video.url,
    );
  }

  Future<List<MusicModel>> fetchSearchResults(String query) async {
    final List<Video> searchResults = await yt.search.search(query);
    final List<MusicModel> videoResult = [];
    for (final Video vid in searchResults) {
      final res = await formatVideo(video: vid, quality: 'High', getUrl: false);
      if (res != null) videoResult.add(res);
    }
    return [];
  }

  Future<List<String>> getUri(Video video) async {
    final StreamManifest manifest =
        await yt.videos.streamsClient.getManifest(video.id);
    final List<AudioOnlyStreamInfo> sortedStreamInfo =
        manifest.audioOnly.sortByBitrate();
    if (Platform.isIOS) {
      final List<AudioOnlyStreamInfo> m4aStreams = sortedStreamInfo
          .where((element) => element.audioCodec.contains('mp4'))
          .toList();
      if (m4aStreams.isNotEmpty) {
        return [
          m4aStreams.first.url.toString(),
          m4aStreams.last.url.toString(),
        ];
      }
    }
    return [
      sortedStreamInfo.first.url.toString(),
      sortedStreamInfo.last.url.toString(),
    ];
  }
}
