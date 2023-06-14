// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int?,
      title: json['title'] as String?,
      poster: json['poster_path'] as String?,
      description: json['overview'] as String?,
      backdrop: json['backdrop_path'] as String?,
      rating: json['vote_average'] as num?,
      releaseDate: json['release_date'] as String?,
      runTime: json['runtime'] as int?,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'title': instance.title,
      'poster_path': instance.poster,
      'id': instance.id,
      'backdrop_path': instance.backdrop,
      'overview': instance.description,
      'vote_average': instance.rating,
      'release_date': instance.releaseDate,
      'runtime': instance.runTime,
    };
