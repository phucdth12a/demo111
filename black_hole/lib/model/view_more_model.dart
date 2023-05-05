import 'package:json_annotation/json_annotation.dart';

part 'view_more_model.g.dart';

@JsonSerializable()
class ViewMoreModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'api')
  String? api;
  @JsonKey(name: 'page_param')
  String? pageParam;
  @JsonKey(name: 'size_param')
  String? sizeParam;
  @JsonKey(name: 'default_size')
  int? defaultSize;
  @JsonKey(name: 'scroll_type')
  String? scrollType;

  ViewMoreModel({
    this.api,
    this.pageParam,
    this.sizeParam,
    this.defaultSize,
    this.scrollType,
  });

  factory ViewMoreModel.fromJson(Map<String, dynamic>? json) =>
      _$ViewMoreModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$ViewMoreModelToJson(this);
}
