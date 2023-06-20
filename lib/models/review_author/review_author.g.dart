// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewAuthor _$ReviewAuthorFromJson(Map<String, dynamic> json) => ReviewAuthor(
      name: json['name'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      authorAvatar: json['avatar_path'] as String?,
    );

Map<String, dynamic> _$ReviewAuthorToJson(ReviewAuthor instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rating': instance.rating,
      'avatar_path': instance.authorAvatar,
    };
