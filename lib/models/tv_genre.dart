import 'package:json_annotation/json_annotation.dart';

part 'tv_genre.g.dart';

@JsonSerializable()
class TvGenre {
  final int? tvgenreId;
  final String? name;

  TvGenre({required this.tvgenreId, required this.name});

  factory TvGenre.fromJson(Map<String, dynamic> json) =>
      _$TvGenreFromJson(json);

  Map<String, dynamic> toJson() => _$TvGenreToJson(this);
}
