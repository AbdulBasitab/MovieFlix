// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../review_author/review_author.dart';

part 'review.g.dart';

@JsonSerializable(explicitToJson: true)
class Review extends Equatable {
  @JsonKey(name: 'author')
  final String? authorUserName;
  @JsonKey(name: 'author_details')
  final ReviewAuthor author;
  @JsonKey(name: 'content')
  final String? reviewContent;
  @JsonKey(name: 'created_at')
  final String? datePosted;
  @JsonKey(includeFromJson: false)
  final bool isExpanded;
  const Review({
    this.authorUserName,
    required this.author,
    this.reviewContent,
    this.datePosted,
    this.isExpanded = false,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  @override
  List<Object?> get props {
    return [
      authorUserName,
      author,
      reviewContent,
      datePosted,
      isExpanded,
    ];
  }

  @override
  bool get stringify => true;
}
