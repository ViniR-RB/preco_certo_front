// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersLocation _$OffersLocationFromJson(Map<String, dynamic> json) =>
    OffersLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      label: json['label'] as String,
      radius: (json['radius'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$OffersLocationToJson(OffersLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'label': instance.label,
      'radius': instance.radius,
    };
