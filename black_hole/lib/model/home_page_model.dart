import 'package:black_hole/model/music_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'modules_model.dart';

part 'home_page_model.g.dart';

@JsonSerializable()
class HomePageModel {
  @JsonKey(name: 'greeting')
  String? greeting;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ItemModules> modules = [];

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ItemPage> page = [];

  HomePageModel({
    this.greeting,
  });

  factory HomePageModel.fromJson(Map<String, dynamic>? json) {
    final data = _$HomePageModelFromJson(json ?? {});
    if (json != null) {
      final jsonModules = json['modules'] as Map<String, dynamic>?;
      if (jsonModules != null) {
        jsonModules.forEach((key, value) {
          data.modules.add(ItemModules(
            id: key,
            data: ModulesModel.fromJson(value),
          ));
          final jsonPage = json[key] as List<dynamic>?;
          if (jsonPage != null) {
            data.page.add(
              ItemPage(
                id: key,
                data: jsonPage.map((e) => MusicModel.fromJson(e)).toList(),
              ),
            );
          }
        });
      }
    }

    return data;
  }

  Map<String, dynamic> toJson() => _$HomePageModelToJson(this);
}

class ItemPage {
  String id;
  List<MusicModel> data;

  ItemPage({required this.id, required this.data});
}

class ItemModules {
  String id;
  ModulesModel data;

  ItemModules({required this.id, required this.data});
}
