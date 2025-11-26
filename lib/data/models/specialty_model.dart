import 'package:lab2/domain/entities/specialty_entity.dart';

class SpecialtyModel {
  final int id;
  final String name;
  final String icon;

  SpecialtyModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory SpecialtyModel.fromJson(Map<String, dynamic> json) {
    return SpecialtyModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }

  SpecialtyEntity toEntity() {
    return SpecialtyEntity(
      id: id,
      name: name,
      icon: icon,
    );
  }
}
