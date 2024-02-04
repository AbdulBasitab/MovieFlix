// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movies_app/models/watch_provider/provider_info.dart';

part 'watch_provider.g.dart';

@JsonSerializable(explicitToJson: true)
class WatchProvider extends Equatable {
  @JsonKey(name: 'link')
  final String? link;
  @JsonKey(name: 'buy')
  final List<ProviderInfo>? buyOptions;
  @JsonKey(name: 'flatrate')
  final List<ProviderInfo>? flatrateOptions;
  @JsonKey(name: 'rent')
  final List<ProviderInfo>? rentOptions;

  const WatchProvider({
    this.link,
    this.buyOptions,
    this.flatrateOptions,
    this.rentOptions,
  });

  factory WatchProvider.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProviderToJson(this);

  @override
  List<Object?> get props => [link, buyOptions, flatrateOptions, rentOptions];

  @override
  bool get stringify => true;
}
