import 'package:lab2/domain/entities/location_entity.dart';

class LocationModel {
  final int id;
  final String city;
  final String location;

  LocationModel({
    required this.id,
    required this.city,
    required this.location,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? 0,
      city: json['city'] ?? json['area'] ?? json['hospital'] ?? '',
      location: json['location'] ?? json['full_address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
      'location': location,
    };
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      city: city,
      location: location,
      name: city,
      address: location,
      distance: 0.0, // Default value, can be calculated later
    );
  }
}
