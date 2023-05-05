import 'package:black_hole/model/artists_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_map_model.g.dart';

@JsonSerializable()
class ArtistMapModel {
  @JsonKey(name: 'primary_artists')
  List<ArtistsModel>? primaryArtists;

  @JsonKey(name: 'featured_artists')
  List<ArtistsModel>? featuredArtists;

  @JsonKey(name: 'artists')
  List<ArtistsModel>? artists;

  ArtistMapModel({
    this.primaryArtists,
    this.featuredArtists,
    this.artists,
  });

  factory ArtistMapModel.fromJson(Map<String, dynamic>? json) =>
      _$ArtistMapModelFromJson(json ?? {});

  Map<String, dynamic> toJson() => _$ArtistMapModelToJson(this);
}
