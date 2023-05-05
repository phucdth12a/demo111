// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistMapModel _$ArtistMapModelFromJson(Map<String, dynamic> json) =>
    ArtistMapModel(
      primaryArtists: (json['primary_artists'] as List<dynamic>?)
          ?.map((e) => ArtistsModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
      featuredArtists: (json['featured_artists'] as List<dynamic>?)
          ?.map((e) => ArtistsModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => ArtistsModel.fromJson(e as Map<String, dynamic>?))
          .toList(),
    );

Map<String, dynamic> _$ArtistMapModelToJson(ArtistMapModel instance) =>
    <String, dynamic>{
      'primary_artists': instance.primaryArtists,
      'featured_artists': instance.featuredArtists,
      'artists': instance.artists,
    };
