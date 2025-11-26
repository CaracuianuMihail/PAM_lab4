import 'package:lab2/domain/entities/slot_entity.dart';

class SlotModel {
  final String from;
  final String to;

  SlotModel({
    required this.from,
    required this.to,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      from: json['from'] ?? '',
      to: json['to'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }

  SlotEntity toEntity() {
    return SlotEntity(
      from: from,
      to: to,
      time: '$from - $to',
      isAvailable: true, // Default value
    );
  }
}
