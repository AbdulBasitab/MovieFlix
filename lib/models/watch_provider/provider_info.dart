// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'provider_info.g.dart';

@JsonSerializable()
class ProviderInfo extends Equatable {
  @JsonKey(name: 'logo_path')
  final String? logoPath;
  @JsonKey(name: 'provider_id')
  final int? providerId;
  @JsonKey(name: 'provider_name')
  final String? providerName;

  const ProviderInfo({
    this.logoPath,
    this.providerId,
    this.providerName,
  });
  factory ProviderInfo.fromJson(Map<String, dynamic> json) =>
      _$ProviderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderInfoToJson(this);

  @override
  List<Object?> get props => [logoPath, providerId, providerName];

  @override
  bool get stringify => true;
}
