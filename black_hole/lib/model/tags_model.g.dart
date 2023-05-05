// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagsModel _$TagsModelFromJson(Map<String, dynamic> json) => TagsModel(
      situation: (json['situation'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mood: (json['mood'] as List<dynamic>?)?.map((e) => e as String).toList(),
      seasonality: (json['seasonality'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genre:
          (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TagsModelToJson(TagsModel instance) => <String, dynamic>{
      'situation': instance.situation,
      'mood': instance.mood,
      'seasonality': instance.seasonality,
      'genre': instance.genre,
    };
