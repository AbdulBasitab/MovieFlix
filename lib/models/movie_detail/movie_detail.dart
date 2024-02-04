// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../genre/genre.dart';

part 'movie_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail extends Equatable {
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

  const MovieDetail({
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

  @override
  List<Object?> get props {
    return [
      movieDetailTitle,
      movieBackdrop,
      movieDetailId,
      description,
      rating,
      releaseDate,
      runTime,
      genres,
    ];
  }

  MovieDetail copyWith({
    String? movieDetailTitle,
    String? movieBackdrop,
    int? movieDetailId,
    String? description,
    num? rating,
    String? releaseDate,
    int? runTime,
    List<Genre>? genres,
  }) {
    return MovieDetail(
      movieDetailTitle: movieDetailTitle ?? this.movieDetailTitle,
      movieBackdrop: movieBackdrop ?? this.movieBackdrop,
      movieDetailId: movieDetailId ?? this.movieDetailId,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      releaseDate: releaseDate ?? this.releaseDate,
      runTime: runTime ?? this.runTime,
      genres: genres ?? this.genres,
    );
  }

  @override
  bool get stringify => true;
}
