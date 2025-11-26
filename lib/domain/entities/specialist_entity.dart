import 'package:lab2/domain/entities/appointment_entity.dart';
import 'package:lab2/domain/entities/date_entity.dart';
import 'package:lab2/domain/entities/location_entity.dart';
import 'package:lab2/domain/entities/timing_entity.dart';

class SpecialistEntity {
  final int id;
  final String name;
  final String image;
  final String specialty;
  final double rating;
  final int years;
  final int patients;
  final AppointmentEntity appointment;
  final List<DateEntity> dates;
  final List<TimingEntity> timings;
  final List<LocationEntity> locations;

  SpecialistEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.specialty,
    required this.rating,
    required this.years,
    required this.patients,
    required this.appointment,
    required this.dates,
    required this.timings,
    required this.locations,
  });
}
