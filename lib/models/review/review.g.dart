// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      authorUserName: json['author'] as String?,
      author:
          ReviewAuthor.fromJson(json['author_details'] as Map<String, dynamic>),
      reviewContent: json['content'] as String?,
      datePosted: json['created_at'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'author': instance.authorUserName,
      'author_details': instance.author.toJson(),
      'content': instance.reviewContent,
      'created_at': instance.datePosted,
    };
