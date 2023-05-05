import 'package:black_hole/helpers/dynamic_converter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'artist_map_model.dart';
import 'rights_model.dart';

part 'more_info_model.g.dart';

@JsonSerializable()
class MoreInfoModel {
  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'song_count')
  @DynamicToIntConverter()
  int? songCount;

  @JsonKey(name: 'artistMap')
  ArtistMapModel? artistMap;

  @JsonKey(name: 'isWeekly')
  String? isWeekly;

  @JsonKey(name: 'firstname')
  String? firstname;

  @JsonKey(name: 'follower_count')
  String? followerCount;

  @JsonKey(name: 'fan_count')
  String? fanCount;

  @JsonKey(name: 'music')
  String? music;

  @JsonKey(name: 'album_id')
  String? albumId;

  @JsonKey(name: 'album')
  String? album;

  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'origin')
  String? origin;

  @JsonKey(name: 'is_dolby_content')
  bool? isDolbyContent;

  @JsonKey(name: '320kbps')
  String? s320kbps;

  @JsonKey(name: 'encrypted_media_url')
  String? encryptedMediaUrl;

  @JsonKey(name: 'encrypted_cache_url')
  String? encryptedCacheUrl;

  @JsonKey(name: 'album_url')
  String? albumUrl;

  @JsonKey(name: 'duration')
  String? duration;

  @JsonKey(name: 'rights')
  RightsModel? rights;

  @JsonKey(name: 'cache_state')
  String? cacheState;

  @JsonKey(name: 'has_lyrics')
  String? hasLyrics;

  @JsonKey(name: 'lyrics_snippet')
  String? lyricsSnippet;

  @JsonKey(name: 'starred')
  String? starred;

  @JsonKey(name: 'copyright_text')
  String? copyrightText;

  @JsonKey(name: 'label_url')
  String? labelUrl;

  @JsonKey(name: 'vcode')
  String? vcode;

  @JsonKey(name: 'vlink')
  String? vlink;

  @JsonKey(name: 'triller_available')
  bool? trillerAvailable;

  @JsonKey(name: 'is_ringtone_available')
  bool? isRingtoneAvailable;

  @JsonKey(name: 'request_jiotune_flag')
  bool? requestJiotuneFlag;

  @JsonKey(name: 'webp')
  String? webp;

  @JsonKey(name: 'lyrics_id')
  String? lyricsId;

  @JsonKey(name: 'Tu Jhoothi Main Makkaar')
  String? tuJhoothiMainMakkaar;

  MoreInfoModel({
    this.releaseDate,
    this.songCount,
    this.artistMap,
    this.isWeekly,
    this.firstname,
    this.followerCount,
    this.fanCount,
    this.music,
    this.albumId,
    this.album,
    this.label,
    this.origin,
    this.isDolbyContent,
    this.s320kbps,
    this.encryptedMediaUrl,
    this.encryptedCacheUrl,
    this.albumUrl,
    this.duration,
    this.rights,
    this.cacheState,
    this.hasLyrics,
    this.lyricsSnippet,
    this.starred,
    this.copyrightText,
    this.labelUrl,
    this.vcode,
    this.vlink,
    this.trillerAvailable,
    this.isRingtoneAvailable,
    this.requestJiotuneFlag,
    this.webp,
    this.lyricsId,
    this.tuJhoothiMainMakkaar,
  });

  factory MoreInfoModel.fromJson(Map<String, dynamic>? json) =>
      _$MoreInfoModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$MoreInfoModelToJson(this);
}
