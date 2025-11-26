import 'package:lab2/domain/entities/profile_entity.dart';

class ProfileModel {
  final String name;
  final String location;
  final String imageUrl;

  ProfileModel({
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
    };
  }

  ProfileEntity toEntity() {
    return ProfileEntity(
      name: name,
      location: location,
      imageUrl: imageUrl,
    );
  }
}
