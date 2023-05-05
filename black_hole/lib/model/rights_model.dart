import 'package:json_annotation/json_annotation.dart';

part 'rights_model.g.dart';

@JsonSerializable()
class RightsModel {
  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'cacheable')
  String? cacheable;

  @JsonKey(name: 'delete_cached_object')
  String? deleteCachedObject;

  @JsonKey(name: 'reason')
  String? reason;

  RightsModel({
    this.code,
    this.cacheable,
    this.deleteCachedObject,
    this.reason,
  });

  factory RightsModel.fromJson(Map<String, dynamic>? json) =>
      _$RightsModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$RightsModelToJson(this);
}
