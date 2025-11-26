import 'package:lab2/domain/entities/appointment_entity.dart';

class AppointmentModel {
  final double fee;
  final String currency;
  final int durationMin;
  final String name;
  final String location;

  AppointmentModel({
    required this.fee,
    required this.currency,
    required this.durationMin,
    required this.name,
    required this.location,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    // Parse duration from wait_time string like "20 mins or less"
    int duration = 0;
    if (json['hospital']?['wait_time'] != null) {
      final waitTime = json['hospital']['wait_time'] as String;
      final match = RegExp(r'(\d+)').firstMatch(waitTime);
      if (match != null) {
        duration = int.parse(match.group(1)!);
      }
    }
    
    return AppointmentModel(
      fee: (json['fee'] ?? 0).toDouble(),
      currency: json['currency'] ?? '৳',
      durationMin: json['durationMin'] ?? json['duration_min'] ?? duration,
      name: json['name'] ?? json['type'] ?? 'Consultation',
      location: json['location'] ?? json['hospital']?['name'] ?? 'Clinic',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fee': fee,
      'currency': currency,
      'durationMin': durationMin,
      'name': name,
      'location': location,
    };
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity(
      fee: fee,
      currency: currency,
      durationMin: durationMin,
      name: name,
      location: location,
      date: name,
      time: location,
    );
  }
}
