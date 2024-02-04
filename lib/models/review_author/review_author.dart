// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'review_author.g.dart';

@JsonSerializable()
class ReviewAuthor extends Equatable {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'rating')
  final double? rating;
  @JsonKey(name: 'avatar_path')
  final String? authorAvatar;

  const ReviewAuthor({
    this.name,
    this.rating,
    this.authorAvatar,
  });

  factory ReviewAuthor.fromJson(Map<String, dynamic> json) =>
      _$ReviewAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewAuthorToJson(this);

  @override
  List<Object?> get props => [name, rating, authorAvatar];

  @override
  bool get stringify => true;
}
