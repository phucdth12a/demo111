// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'view_more_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewMoreModel _$ViewMoreModelFromJson(Map<String, dynamic> json) =>
    ViewMoreModel(
      api: json['api'] as String?,
      pageParam: json['page_param'] as String?,
      sizeParam: json['size_param'] as String?,
      defaultSize: json['default_size'] as int?,
      scrollType: json['scroll_type'] as String?,
    )..id = json['id'] as String?;

Map<String, dynamic> _$ViewMoreModelToJson(ViewMoreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'api': instance.api,
      'page_param': instance.pageParam,
      'size_param': instance.sizeParam,
      'default_size': instance.defaultSize,
      'scroll_type': instance.scrollType,
    };
