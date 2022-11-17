import 'package:json_annotation/json_annotation.dart';
import 'movie_genre.dart';
part 'moviedetail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TrendingMovieDetail {
  @JsonKey(name: 'title')
  final String? movieDetailTitle;

  @JsonKey(name: 'backdrop_path')
  final String movieBackdrop;

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

  TrendingMovieDetail({
    this.movieDetailTitle,
    required this.movieBackdrop,
    this.movieDetailId,
    this.description,
    this.rating,
    this.releaseDate,
    this.runTime,
    this.genres = const [],
  });

  factory TrendingMovieDetail.fromJson(Map<String, dynamic> json) =>
      _$TrendingMovieDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingMovieDetailToJson(this);
  //   return TrendingMovieDetail(
  //     movieDetailId: json["id"],
  //     movieDetailTitle: json["title"],
  //     movieImage: json["poster_path"],
  //     backdrop: json["backdrop_path"],
  //     description: json["overview"],
  //     rating: json["vote_average"],
  //     releaseDate: json["release_date"],
  //     runTime: json["runtime"],
  //     imdbId: json["imdb_id"],
  //     genres: (json["genres"] as List<dynamic>)
  //         .map((e) => Genre.fromJson(e))
  //         .toList(),
  //   );
  // }
}
