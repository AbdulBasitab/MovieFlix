import 'package:json_annotation/json_annotation.dart';

part 'popular_tv_model.g.dart';

@JsonSerializable()
class PopularTv {
  @JsonKey(name: 'poster_path')
  final String? popTvPoster;

  @JsonKey(name: 'id')
  final int? popTvId;

  @JsonKey(name: 'name')
  final String? popTvTitle;

  // @JsonKey(defaultValue: false)
  // final bool isFavourite;

  PopularTv(
      {required this.popTvId,
      required this.popTvPoster,
      required this.popTvTitle});

  factory PopularTv.fromJson(Map<String, dynamic> json) =>
      _$PopularTvFromJson(json);

  Map<String, dynamic> toJson() => _$PopularTvToJson(this);
}
