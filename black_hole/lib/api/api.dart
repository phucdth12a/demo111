import 'dart:convert';
import 'dart:io';

import 'package:black_hole/model/home_page_model.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:logging/logging.dart';

class SaavnAPI {
  List preferredLanguages = Hive.box('settings')
      .get('preferredLanguage', defaultValue: ['Hindi']) as List;
  Map<String, String> headers = {};
  String baseUrl = 'www.jiosaavn.com';
  String apiStr = '/api.php?_format=json&_marker=0&api_version=4&ctx=web6dot0';
  Box settingBox = Hive.box('settings');
  Map<String, String> endpoints = {
    'homeData': '__call=webapi.getLaunchData',
    'topSearches': '__call=content.getTopSearches',
    'fromToken': '__call=webapi.get',
    'featuredRadio': '__call=webradio.createFeaturedStation',
    'artistRadio': '__call=webradio.createArtistStation',
    'entityRadio': '__call=webradio.createEntityStation',
    'radioSongs': '__call=webradio.getSong',
    'songDetails': '__call=song.getDetails',
    'playlistDetails': '__call=playlist.getDetails',
    'albumDetails': '__call=content.getAlbumDetails',
    'getResults': '__call=search.getResults',
    'albumResults': '__call=search.getAlbumResults',
    'artistResults': '__call=search.getArtistResults',
    'playlistResults': '__call=search.getPlaylistResults',
    'getReco': '__call=reco.getreco',
    'getAlbumReco': '__call=reco.getAlbumReco', // still not used
    'artistOtherTopSongs':
        '__call=search.artistOtherTopSongs', // still not used
  };

  Future<Response> getResponse(
    String params, {
    bool usev4 = true,
    bool useProxy = false,
  }) async {
    Uri url;
    if (!usev4) {
      url = Uri.https(
          baseUrl, '$apiStr&$params'.replaceAll('&api_version=4', ''));
    } else {
      url = Uri.https(baseUrl, '$apiStr&$params');
    }
    preferredLanguages =
        preferredLanguages.map((e) => e.toLowerCase()).toList();
    final languageHeader = 'L=${preferredLanguages.join('%2C')}';
    headers = {'cookie': languageHeader, 'Accept': '*/*'};

    if (useProxy && settingBox.get('useProxy', defaultValue: false) as bool) {
      final proxyIP = settingBox.get('proxyIp');
      final proxyPort = settingBox.get('proxyPort');
      final httpClient = HttpClient();
      httpClient.findProxy = (uri) {
        return 'PROXY $proxyIP:$proxyPort;';
      };
      httpClient.badCertificateCallback =
          (cert, host, port) => Platform.isAndroid;
      final myClient = IOClient(httpClient);
      return myClient.get(url, headers: headers);
    }
    print("url == $url");
    return get(url, headers: headers).onError(
      (error, stackTrace) {
        return Response(
          {
            'status': 'failure',
            'error': error.toString(),
          }.toString(),
          404,
        );
      },
    );
  }

  Future<HomePageModel?> fetchHomePageData() async {
    final res = await getResponse(endpoints['homeData']!);
    if (res.statusCode == 200) {
      return HomePageModel.fromJson(
          json.decode(res.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<String?> createRadio(
      {required List<String> names,
      required String stationType,
      String? language}) async {
    String? params;
    if (stationType == 'featured') {
      params =
          'name=${names[0]}&language=$language&${endpoints['featuredRadio']}';
    }
    if (stationType == 'artist') {
      params = 'name${names[0]}&language=$language&${endpoints['artistRadio']}';
    }
    if (stationType == 'entity') {
      params =
          'entity_id=${names.map((e) => e).toList()}&entity_type=queue&${endpoints['entityRadio']}';
    }
    final res = await getResponse(params!);
    if (res.statusCode == 200) {
      final getMain = jsonDecode(res.body);
      return (getMain as Map)['stationid'];
    }
    return null;
  }

  Future<List> getRadioSongs(
      {required String stationId, int count = 20, int next = 1}) async {
    if (count > 1) {
      final String params =
          'stationid=$stationId&k=$count&next=$next&${endpoints['radioSongs']}';
      final res = await getResponse(params);
      return [];
    }
    return [];
  }
}
