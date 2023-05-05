// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modules_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModulesModel _$ModulesModelFromJson(Map<String, dynamic> json) => ModulesModel(
      source: json['source'] as String?,
      position: json['position'] as int?,
      score: json['score'] as String?,
      bucket: json['bucket'] as String?,
      scrollType: json['scroll_type'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      highlight: json['highlight'] as String?,
      simpleHeader: json['simpleHeader'] as bool?,
      noHeader: json['noHeader'] as bool?,
      viewMore: json['view_more'] == null
          ? null
          : ViewMoreModel.fromJson(json['view_more'] as Map<String, dynamic>?),
      isJTModule: json['is_JT_module'] as bool?,
    );

Map<String, dynamic> _$ModulesModelToJson(ModulesModel instance) =>
    <String, dynamic>{
      'source': instance.source,
      'position': instance.position,
      'score': instance.score,
      'bucket': instance.bucket,
      'scroll_type': instance.scrollType,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'highlight': instance.highlight,
      'simpleHeader': instance.simpleHeader,
      'noHeader': instance.noHeader,
      'view_more': instance.viewMore,
      'is_JT_module': instance.isJTModule,
    };
