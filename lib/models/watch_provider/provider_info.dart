// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'provider_info.g.dart';

@JsonSerializable()
class ProviderInfo {
  @JsonKey(name: 'logo_path')
  String? logoPath;
  @JsonKey(name: 'provider_id')
  int? providerId;
  @JsonKey(name: 'provider_name')
  String? providerName;

  ProviderInfo({
    this.logoPath,
    this.providerId,
    this.providerName,
  });
  factory ProviderInfo.fromJson(Map<String, dynamic> json) =>
      _$ProviderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderInfoToJson(this);
}
