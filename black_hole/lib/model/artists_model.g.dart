// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artists_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistsModel _$ArtistsModelFromJson(Map<String, dynamic> json) => ArtistsModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      image: json['image'] as String?,
      type: json['type'] as String?,
      permaUrl: json['perma_url'] as String?,
    );

Map<String, dynamic> _$ArtistsModelToJson(ArtistsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'image': instance.image,
      'type': instance.type,
      'perma_url': instance.permaUrl,
    };
