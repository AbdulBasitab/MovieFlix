// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchProvider _$WatchProviderFromJson(Map<String, dynamic> json) =>
    WatchProvider(
      link: json['link'] as String?,
      buyOptions: (json['buy'] as List<dynamic>?)
          ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      flatrateOptions: (json['flatrate'] as List<dynamic>?)
          ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      rentOptions: (json['rent'] as List<dynamic>?)
          ?.map((e) => ProviderInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WatchProviderToJson(WatchProvider instance) =>
    <String, dynamic>{
      'link': instance.link,
      'buy': instance.buyOptions?.map((e) => e.toJson()).toList(),
      'flatrate': instance.flatrateOptions?.map((e) => e.toJson()).toList(),
      'rent': instance.rentOptions?.map((e) => e.toJson()).toList(),
    };
