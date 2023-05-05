// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoreInfoModel _$MoreInfoModelFromJson(Map<String, dynamic> json) =>
    MoreInfoModel(
      releaseDate: json['release_date'] as String?,
      songCount: const DynamicToIntConverter().fromJson(json['song_count']),
      artistMap: json['artistMap'] == null
          ? null
          : ArtistMapModel.fromJson(json['artistMap'] as Map<String, dynamic>?),
      isWeekly: json['isWeekly'] as String?,
      firstname: json['firstname'] as String?,
      followerCount: json['follower_count'] as String?,
      fanCount: json['fan_count'] as String?,
      music: json['music'] as String?,
      albumId: json['album_id'] as String?,
      album: json['album'] as String?,
      label: json['label'] as String?,
      origin: json['origin'] as String?,
      isDolbyContent: json['is_dolby_content'] as bool?,
      s320kbps: json['320kbps'] as String?,
      encryptedMediaUrl: json['encrypted_media_url'] as String?,
      encryptedCacheUrl: json['encrypted_cache_url'] as String?,
      albumUrl: json['album_url'] as String?,
      duration: json['duration'] as String?,
      rights: json['rights'] == null
          ? null
          : RightsModel.fromJson(json['rights'] as Map<String, dynamic>?),
      cacheState: json['cache_state'] as String?,
      hasLyrics: json['has_lyrics'] as String?,
      lyricsSnippet: json['lyrics_snippet'] as String?,
      starred: json['starred'] as String?,
      copyrightText: json['copyright_text'] as String?,
      labelUrl: json['label_url'] as String?,
      vcode: json['vcode'] as String?,
      vlink: json['vlink'] as String?,
      trillerAvailable: json['triller_available'] as bool?,
      isRingtoneAvailable: json['is_ringtone_available'] as bool?,
      requestJiotuneFlag: json['request_jiotune_flag'] as bool?,
      webp: json['webp'] as String?,
      lyricsId: json['lyrics_id'] as String?,
      tuJhoothiMainMakkaar: json['Tu Jhoothi Main Makkaar'] as String?,
    );

Map<String, dynamic> _$MoreInfoModelToJson(MoreInfoModel instance) =>
    <String, dynamic>{
      'release_date': instance.releaseDate,
      'song_count': const DynamicToIntConverter().toJson(instance.songCount),
      'artistMap': instance.artistMap,
      'isWeekly': instance.isWeekly,
      'firstname': instance.firstname,
      'follower_count': instance.followerCount,
      'fan_count': instance.fanCount,
      'music': instance.music,
      'album_id': instance.albumId,
      'album': instance.album,
      'label': instance.label,
      'origin': instance.origin,
      'is_dolby_content': instance.isDolbyContent,
      '320kbps': instance.s320kbps,
      'encrypted_media_url': instance.encryptedMediaUrl,
      'encrypted_cache_url': instance.encryptedCacheUrl,
      'album_url': instance.albumUrl,
      'duration': instance.duration,
      'rights': instance.rights,
      'cache_state': instance.cacheState,
      'has_lyrics': instance.hasLyrics,
      'lyrics_snippet': instance.lyricsSnippet,
      'starred': instance.starred,
      'copyright_text': instance.copyrightText,
      'label_url': instance.labelUrl,
      'vcode': instance.vcode,
      'vlink': instance.vlink,
      'triller_available': instance.trillerAvailable,
      'is_ringtone_available': instance.isRingtoneAvailable,
      'request_jiotune_flag': instance.requestJiotuneFlag,
      'webp': instance.webp,
      'lyrics_id': instance.lyricsId,
      'Tu Jhoothi Main Makkaar': instance.tuJhoothiMainMakkaar,
    };
