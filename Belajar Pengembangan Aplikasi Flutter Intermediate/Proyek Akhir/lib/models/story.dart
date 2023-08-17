import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story{
  String id;
  String name;
  String description;
  String photoUrl;
  String createdAt;
  @JsonKey(name: 'lat')
  double? latitude;
  @JsonKey(name: 'lon')
  double? longitude;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.latitude,
    this.longitude
  });

  factory Story.fromMap(Map<String, dynamic> map) => _$StoryFromJson(map);
}