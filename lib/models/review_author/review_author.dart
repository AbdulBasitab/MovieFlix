import 'package:json_annotation/json_annotation.dart';

part 'review_author.g.dart';

@JsonSerializable()
class ReviewAuthor {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'avatar_path')
  String? authorAvatar;

  ReviewAuthor({
    this.name,
    this.rating,
    this.authorAvatar,
  });

  factory ReviewAuthor.fromJson(Map<String, dynamic> json) =>
      _$ReviewAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewAuthorToJson(this);
}
