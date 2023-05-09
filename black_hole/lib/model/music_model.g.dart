// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicModel _$MusicModelFromJson(Map<String, dynamic> json) => MusicModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      headerDesc: json['header_desc'] as String?,
      type: json['type'] as String?,
      permaUrl: json['perma_url'] as String?,
      image: json['image'] as String?,
      language: json['language'] as String?,
      year: json['year'] as String?,
      playCount: json['play_count'] as String?,
      explicitContent: json['explicit_content'] as String?,
      listCount: json['list_count'] as String?,
      listType: json['list_type'] as String?,
      list: json['list'] as String?,
      moreInfo: json['more_info'] == null
          ? null
          : MoreInfoModel.fromJson(json['more_info'] as Map<String, dynamic>?),
      tuJhoothiMainMakkaar: json['Tu Jhoothi Main Makkaar'] as String?,
      artist: json['artist'] as String?,
      duration: json['duration'] as String?,
      dateAdded: json['dateAdded'] == null
          ? null
          : DateTime.parse(json['dateAdded'] as String),
      album: json['album'] as String?,
      url: json['url'] as String?,
      lowUrl: json['lowUrl'] as String?,
      highUrl: json['highUrl'] as String?,
      url320kbps: json['320kbps'] as String?,
      quality: json['quality'] as String?,
      hasLyrics: json['has_lyrics'] as String?,
      releaseDate: json['release_date'] as String?,
      albumId: json['album_id'] as String?,
      expireAt: json['expire_at'] as String?,
    );

Map<String, dynamic> _$MusicModelToJson(MusicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'header_desc': instance.headerDesc,
      'type': instance.type,
      'perma_url': instance.permaUrl,
      'image': instance.image,
      'language': instance.language,
      'year': instance.year,
      'play_count': instance.playCount,
      'explicit_content': instance.explicitContent,
      'list_count': instance.listCount,
      'list_type': instance.listType,
      'list': instance.list,
      'more_info': instance.moreInfo,
      'Tu Jhoothi Main Makkaar': instance.tuJhoothiMainMakkaar,
      'artist': instance.artist,
      'duration': instance.duration,
      'dateAdded': instance.dateAdded?.toIso8601String(),
      'album': instance.album,
      'url': instance.url,
      'lowUrl': instance.lowUrl,
      'highUrl': instance.highUrl,
      '320kbps': instance.url320kbps,
      'quality': instance.quality,
      'has_lyrics': instance.hasLyrics,
      'release_date': instance.releaseDate,
      'album_id': instance.albumId,
      'expire_at': instance.expireAt,
    };
