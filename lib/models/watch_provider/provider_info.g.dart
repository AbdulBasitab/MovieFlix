// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderInfo _$ProviderInfoFromJson(Map<String, dynamic> json) => ProviderInfo(
      logoPath: json['logo_path'] as String?,
      providerId: json['provider_id'] as int?,
      providerName: json['provider_name'] as String?,
    );

Map<String, dynamic> _$ProviderInfoToJson(ProviderInfo instance) =>
    <String, dynamic>{
      'logo_path': instance.logoPath,
      'provider_id': instance.providerId,
      'provider_name': instance.providerName,
    };
