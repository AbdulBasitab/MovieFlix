// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  bool operator ==(covariant Movie other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.poster == poster &&
        other.id == id &&
        other.backdrop == backdrop &&
        other.description == description &&
        other.rating == rating &&
        other.releaseDate == releaseDate &&
        other.runTime == runTime;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        poster.hashCode ^
        id.hashCode ^
        backdrop.hashCode ^
        description.hashCode ^
        rating.hashCode ^
        releaseDate.hashCode ^
        runTime.hashCode;
  }
}
