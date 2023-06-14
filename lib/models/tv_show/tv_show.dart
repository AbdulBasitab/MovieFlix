import 'package:json_annotation/json_annotation.dart';

import '../genre/genre.dart';

part 'tv_show.g.dart';

@JsonSerializable()
class TvShow {
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
  final num? rating;

  @JsonKey(name: 'genres')
  final List<Genre>? genres;

  // @JsonKey(defaultValue: false)
  // final bool isFavourite;

  TvShow({
    required this.id,
    required this.poster,
    required this.title,
    required this.episodes,
    required this.firstairDate,
    required this.genres,
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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TvShow &&
        other.id == id &&
        other.poster == poster &&
        other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ poster.hashCode ^ title.hashCode;
}
