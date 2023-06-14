import 'package:json_annotation/json_annotation.dart';

import '../genre/genre.dart';

part 'movie_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail {
  @JsonKey(name: 'title')
  final String? movieDetailTitle;

  @JsonKey(name: 'backdrop_path')
  final String? movieBackdrop;

  @JsonKey(name: 'id')
  final int? movieDetailId;

  @JsonKey(name: 'overview')
  final String? description;

  @JsonKey(name: 'vote_average')
  final num? rating;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'runtime')
  final int? runTime;

  @JsonKey(name: 'genres')
  final List<Genre> genres;

  MovieDetail({
    this.movieDetailTitle,
    this.movieBackdrop,
    this.movieDetailId,
    this.description,
    this.rating,
    this.releaseDate,
    this.runTime,
    this.genres = const [],
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}
