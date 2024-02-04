// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../genre/genre.dart';

part 'tv_show_detail.g.dart';

@JsonSerializable()
class TvShowDetail extends Equatable {
  @JsonKey(name: 'backdrop_path')
  final String? tvBackdrop;

  @JsonKey(name: 'name')
  final String? tvTitle;

  @JsonKey(name: 'id')
  final int? tvId;

  @JsonKey(name: 'overview')
  final String? tvDescription;

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

  const TvShowDetail({
    this.tvBackdrop,
    this.tvTitle,
    this.tvId,
    this.tvDescription,
    this.seasons,
    this.episodes,
    this.firstairDate,
    this.lastairDate,
    this.status,
    this.rating,
    this.genres,
  });

  factory TvShowDetail.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailToJson(this);

  @override
  List<Object?> get props {
    return [
      tvBackdrop,
      tvTitle,
      tvId,
      tvDescription,
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
