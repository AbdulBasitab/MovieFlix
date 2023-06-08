// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail(
      movieDetailTitle: json['title'] as String?,
      movieBackdrop: json['backdrop_path'] as String?,
      movieDetailId: json['id'] as int?,
      description: json['overview'] as String?,
      rating: json['vote_average'] as num?,
      releaseDate: json['release_date'] as String?,
      runTime: json['runtime'] as int?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) =>
    <String, dynamic>{
      'title': instance.movieDetailTitle,
      'backdrop_path': instance.movieBackdrop,
      'id': instance.movieDetailId,
      'overview': instance.description,
      'vote_average': instance.rating,
      'release_date': instance.releaseDate,
      'runtime': instance.runTime,
      'genres': instance.genres.map((e) => e.toJson()).toList(),
    };
