// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rights_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RightsModel _$RightsModelFromJson(Map<String, dynamic> json) => RightsModel(
      code: json['code'] as String?,
      cacheable: json['cacheable'] as String?,
      deleteCachedObject: json['delete_cached_object'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$RightsModelToJson(RightsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'cacheable': instance.cacheable,
      'delete_cached_object': instance.deleteCachedObject,
      'reason': instance.reason,
    };
