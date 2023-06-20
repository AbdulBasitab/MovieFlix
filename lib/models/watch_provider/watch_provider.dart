// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:movies_app/models/watch_provider/provider_info.dart';

part 'watch_provider.g.dart';

@JsonSerializable(explicitToJson: true)
class WatchProvider {
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'buy')
  List<ProviderInfo>? buyOptions;
  @JsonKey(name: 'flatrate')
  List<ProviderInfo>? flatrateOptions;
  @JsonKey(name: 'rent')
  List<ProviderInfo>? rentOptions;

  WatchProvider({
    this.link,
    this.buyOptions,
    this.flatrateOptions,
    this.rentOptions,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderToJson(this);
}
