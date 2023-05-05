import 'package:json_annotation/json_annotation.dart';

import 'view_more_model.dart';

part 'modules_model.g.dart';

@JsonSerializable()
class ModulesModel {
  @JsonKey(name: 'source')
  String? source;
  @JsonKey(name: 'position')
  int? position;
  @JsonKey(name: 'score')
  String? score;
  @JsonKey(name: 'bucket')
  String? bucket;
  @JsonKey(name: 'scroll_type')
  String? scrollType;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'subtitle')
  String? subtitle;
  @JsonKey(name: 'highlight')
  String? highlight;
  @JsonKey(name: 'simpleHeader')
  bool? simpleHeader;
  @JsonKey(name: 'noHeader')
  bool? noHeader;
  @JsonKey(name: 'view_more')
  ViewMoreModel? viewMore;
  @JsonKey(name: 'is_JT_module')
  bool? isJTModule;

  ModulesModel({
    this.source,
    this.position,
    this.score,
    this.bucket,
    this.scrollType,
    this.title,
    this.subtitle,
    this.highlight,
    this.simpleHeader,
    this.noHeader,
    this.viewMore,
    this.isJTModule,
  });

  factory ModulesModel.fromJson(Map<String, dynamic>? json) =>
      _$ModulesModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$ModulesModelToJson(this);
}
