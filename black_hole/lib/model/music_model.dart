import 'package:json_annotation/json_annotation.dart';

import 'more_info_model.dart';

part 'music_model.g.dart';

@JsonSerializable()
class MusicModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'subtitle')
  String? subtitle;

  @JsonKey(name: 'header_desc')
  String? headerDesc;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'perma_url')
  String? permaUrl;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'language')
  String? language;

  @JsonKey(name: 'year')
  String? year;

  @JsonKey(name: 'play_count')
  String? playCount;

  @JsonKey(name: 'explicit_content')
  String? explicitContent;

  @JsonKey(name: 'list_count')
  String? listCount;

  @JsonKey(name: 'list_type')
  String? listType;

  @JsonKey(name: 'list')
  String? list;

  @JsonKey(name: 'more_info')
  MoreInfoModel? moreInfo;

  @JsonKey(name: 'Tu Jhoothi Main Makkaar')
  String? tuJhoothiMainMakkaar;

  @JsonKey(name: 'artist')
  String? artist;

  @JsonKey(name: 'duration')
  String? duration;

  @JsonKey(name: 'dateAdded')
  DateTime? dateAdded;

  @JsonKey(name: 'album')
  String? album;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'lowUrl')
  String? lowUrl;

  @JsonKey(name: 'highUrl')
  String? highUrl;

  @JsonKey(name: '320kbps')
  String? url320kbps;

  @JsonKey(name: 'quality')
  String? quality;

  @JsonKey(name: 'has_lyrics')
  String? hasLyrics;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'album_id')
  String? albumId;

  @JsonKey(name: 'expire_at')
  String? expireAt;

  @JsonKey(name: 'genre')
  String? genre;

  @JsonKey(name: 'path')
  String? path;

  @JsonKey(name: 'secondImage')
  String? secondImage;

  MusicModel({
    this.id,
    this.title,
    this.subtitle,
    this.headerDesc,
    this.type,
    this.permaUrl,
    this.image,
    this.language,
    this.year,
    this.playCount,
    this.explicitContent,
    this.listCount,
    this.listType,
    this.list,
    this.moreInfo,
    this.tuJhoothiMainMakkaar,
    this.artist,
    this.duration,
    this.dateAdded,
    this.album,
    this.url,
    this.lowUrl,
    this.highUrl,
    this.url320kbps,
    this.quality,
    this.hasLyrics,
    this.releaseDate,
    this.albumId,
    this.expireAt,
    this.genre,
    this.path,
    this.secondImage,
  });

  factory MusicModel.fromJson(Map<String, dynamic>? json) =>
      _$MusicModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$MusicModelToJson(this);
}
