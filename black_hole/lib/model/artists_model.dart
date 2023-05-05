import 'package:json_annotation/json_annotation.dart';

part 'artists_model.g.dart';

@JsonSerializable()
class ArtistsModel {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'role')
  String? role;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'perma_url')
  String? permaUrl;

  ArtistsModel({
    this.id,
    this.name,
    this.role,
    this.image,
    this.type,
    this.permaUrl,
  });

  factory ArtistsModel.fromJson(Map<String, dynamic>? json) =>
      _$ArtistsModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$ArtistsModelToJson(this);
}
