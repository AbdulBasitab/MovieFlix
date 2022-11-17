// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingMovie _$TrendingMovieFromJson(Map<String, dynamic> json) =>
    TrendingMovie(
      movieId: json['id'] as int?,
      movieTitle: json['title'] as String?,
      moviePoster: json['poster_path'] as String?,
    );

Map<String, dynamic> _$TrendingMovieToJson(TrendingMovie instance) =>
    <String, dynamic>{
      'title': instance.movieTitle,
      'poster_path': instance.moviePoster,
      'id': instance.movieId,
    };
