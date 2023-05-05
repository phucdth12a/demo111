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
  });

  factory MusicModel.fromJson(Map<String, dynamic>? json) =>
      _$MusicModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$MusicModelToJson(this);
}
