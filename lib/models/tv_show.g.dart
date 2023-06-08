// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShow _$TvShowFromJson(Map<String, dynamic> json) => TvShow(
      id: json['id'] as int?,
      poster: json['poster_path'] as String?,
      title: json['name'] as String?,
      episodes: json['number_of_episodes'] as int?,
      firstairDate: json['first_air_date'] as String?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastairDate: json['last_air_date'] as String?,
      rating: json['vote_average'] as num?,
      seasons: json['number_of_seasons'] as int?,
      status: json['status'] as String?,
      backdrop: json['backdrop_path'] as String?,
      description: json['overview'] as String?,
    );

Map<String, dynamic> _$TvShowToJson(TvShow instance) => <String, dynamic>{
      'poster_path': instance.poster,
      'id': instance.id,
      'backdrop_path': instance.backdrop,
      'name': instance.title,
      'overview': instance.description,
      'number_of_seasons': instance.seasons,
      'number_of_episodes': instance.episodes,
      'first_air_date': instance.firstairDate,
      'last_air_date': instance.lastairDate,
      'status': instance.status,
      'vote_average': instance.rating,
      'genres': instance.genres,
    };
