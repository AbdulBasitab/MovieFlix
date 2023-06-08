import 'package:json_annotation/json_annotation.dart';

// import 'genre.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'poster_path')
  final String? poster;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'backdrop_path')
  final String? backdrop;

  @JsonKey(name: 'overview')
  final String? description;

  @JsonKey(name: 'vote_average')
  final num? rating;

  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @JsonKey(name: 'runtime')
  final int? runTime;

  Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.description,
    required this.backdrop,
    required this.rating,
    required this.releaseDate,
    required this.runTime,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.id == id &&
        other.title == title &&
        other.poster == poster;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ poster.hashCode;
}
