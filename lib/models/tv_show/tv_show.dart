// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../genre/genre.dart';

part 'tv_show.g.dart';

@JsonSerializable()
@Collection()
class TvShow extends Equatable {
  @JsonKey(includeFromJson: false)
  Id isarId = Isar.autoIncrement;

  @JsonKey(name: 'poster_path')
  final String? poster;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'backdrop_path')
  final String? backdrop;

  @JsonKey(name: 'name')
  final String? title;

  @JsonKey(name: 'overview')
  final String? description;

  @JsonKey(name: 'number_of_seasons')
  final int? seasons;

  @JsonKey(name: 'number_of_episodes')
  final int? episodes;

  @JsonKey(name: 'first_air_date')
  final String? firstairDate;

  @JsonKey(name: 'last_air_date')
  final String? lastairDate;

  @JsonKey(name: 'status')
  final String? status;

  @JsonKey(name: 'vote_average')
  final double? rating;

  @JsonKey(name: 'genres')
  @ignore
  final List<Genre>? genres;

  TvShow({
    required this.id,
    required this.poster,
    required this.title,
    required this.episodes,
    required this.firstairDate,
    this.genres,
    required this.lastairDate,
    required this.rating,
    required this.seasons,
    required this.status,
    required this.backdrop,
    required this.description,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowToJson(this);

  @override
  List<Object?> get props {
    return [
      isarId,
      poster,
      id,
      backdrop,
      title,
      description,
      seasons,
      episodes,
      firstairDate,
      lastairDate,
      status,
      rating,
      genres,
    ];
  }

  @override
  bool get stringify => true;
}
