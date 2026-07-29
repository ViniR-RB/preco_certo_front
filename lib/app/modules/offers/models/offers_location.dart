import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'offers_location.g.dart';

@JsonSerializable()
class OffersLocation {
  const OffersLocation({
    required this.latitude,
    required this.longitude,
    required this.label,
    this.radius = 5,
  });

  static const allowedRadii = <int>[1, 5, 10, 15, 20, 30];

  final double latitude;
  final double longitude;
  final String label;
  final int radius;

  OffersLocation copyWith({int? radius}) => OffersLocation(
    latitude: latitude,
    longitude: longitude,
    label: label,
    radius: radius ?? this.radius,
  );

  String toStorage() => jsonEncode(toJson());

  factory OffersLocation.fromStorage(String value) {
    final json = jsonDecode(value) as Map<String, dynamic>;
    final location = _$OffersLocationFromJson(json);
    return location.copyWith(
      radius: allowedRadii.contains(location.radius) ? location.radius : 5,
    );
  }

  factory OffersLocation.fromJson(Map<String, dynamic> json) =>
      _$OffersLocationFromJson(json);

  Map<String, dynamic> toJson() => _$OffersLocationToJson(this);
}

class AddressSuggestion {
  const AddressSuggestion({
    required this.latitude,
    required this.longitude,
    required this.label,
  });

  final double latitude;
  final double longitude;
  final String label;
}
