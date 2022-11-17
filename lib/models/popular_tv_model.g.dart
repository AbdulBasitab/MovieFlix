// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_tv_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularTv _$PopularTvFromJson(Map<String, dynamic> json) => PopularTv(
      popTvId: json['id'] as int?,
      popTvPoster: json['poster_path'] as String?,
      popTvTitle: json['name'] as String?,
    );

Map<String, dynamic> _$PopularTvToJson(PopularTv instance) => <String, dynamic>{
      'poster_path': instance.popTvPoster,
      'id': instance.popTvId,
      'name': instance.popTvTitle,
    };
