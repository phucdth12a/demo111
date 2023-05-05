import 'package:json_annotation/json_annotation.dart';

part 'tags_model.g.dart';

@JsonSerializable()
class TagsModel {
  @JsonKey(name: 'situation')
  List<String>? situation;

  @JsonKey(name: 'mood')
  List<String>? mood;

  @JsonKey(name: 'seasonality')
  List<String>? seasonality;

  @JsonKey(name: 'genre')
  List<String>? genre;

  TagsModel({
    this.situation,
    this.mood,
    this.seasonality,
    this.genre,
  });

  factory TagsModel.fromJson(Map<String, dynamic>? json) =>
      _$TagsModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$TagsModelToJson(this);
}
