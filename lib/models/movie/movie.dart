// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

// import 'genre.dart';

part 'movie.g.dart';

@JsonSerializable()
@Collection()
class Movie extends Equatable {
  @JsonKey(includeFromJson: false)
  Id isarId = Isar.autoIncrement;

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
  final double? rating;

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
  List<Object?> get props {
    return [
      title,
      poster,
      id,
      backdrop,
      description,
      rating,
      releaseDate,
      runTime,
    ];
  }

  @override
  bool get stringify => true;
}
