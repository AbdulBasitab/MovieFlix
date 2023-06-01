import 'package:json_annotation/json_annotation.dart';

part 'trending_movie_model.g.dart';

@JsonSerializable()
class TrendingMovie {
  @JsonKey(name: 'title')
  final String? movieTitle;

  @JsonKey(name: 'poster_path')
  final String? moviePoster;

  @JsonKey(name: 'id')
  final int? movieId;

  // @JsonKey(defaultValue: false)
  // final bool isFavourite;

  TrendingMovie({
    required this.movieId,
    required this.movieTitle,
    required this.moviePoster,
  });

  factory TrendingMovie.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieFromJson(json);
  Map<String, dynamic> toJson() => _$TrendingMovieToJson(this);
}
