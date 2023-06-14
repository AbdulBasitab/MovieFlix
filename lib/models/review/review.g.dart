// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      author:
          ReviewAuthor.fromJson(json['author_details'] as Map<String, dynamic>),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'author_details': instance.author.toJson(),
      'content': instance.content,
    };
