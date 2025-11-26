import 'package:lab2/domain/entities/timing_entity.dart';

class TimingModel {
  final String day;
  final String time;

  TimingModel({
    required this.day,
    required this.time,
  });

  factory TimingModel.fromJson(Map<String, dynamic> json) {
    return TimingModel(
      day: json['day'] ?? '',
      time: json['time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time': time,
    };
  }

  TimingEntity toEntity() {
    return TimingEntity(
      day: day,
      time: time,
    );
  }
}
