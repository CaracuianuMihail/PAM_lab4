import 'package:lab2/data/models/appointment_model.dart';
import 'package:lab2/data/models/date_model.dart';
import 'package:lab2/data/models/location_model.dart';
import 'package:lab2/data/models/timing_model.dart';
import 'package:lab2/domain/entities/specialist_entity.dart';

class SpecialistModel {
  final int id;
  final String name;
  final String image;
  final String specialty;
  final double rating;
  final int years;
  final int patients;
  final AppointmentModel appointment;
  final List<DateModel> dates;
  final List<TimingModel> timings;
  final List<LocationModel> locations;

  SpecialistModel({
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

  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    // Handle appointment - may be null for simple list view
    AppointmentModel appointment;
    if (json['appointment'] != null) {
      appointment = AppointmentModel.fromJson(json['appointment']);
    } else {
      // Create default appointment for simple specialist list
      appointment = AppointmentModel(
        fee: 0,
        currency: '৳',
        durationMin: 0,
        name: 'Consultation',
        location: 'Clinic',
      );
    }

    // Handle dates - may be null or empty
    List<DateModel> dateList = [];
    if (json['dates'] != null) {
      var datesFromJson = json['dates'] as List;
      dateList = datesFromJson.map((i) => DateModel.fromJson(i)).toList();
    } else if (json['appointment']?['available_days'] != null) {
      // Parse available_days from details endpoint
      var availableDays = json['appointment']['available_days'] as List;
      dateList = availableDays.map((dayData) {
        final day = dayData['day'] ?? '';
        final slots = dayData['slots'] as List? ?? [];
        
        // Convert slot strings like "06:00 - 06:30" to SlotModel format
        List<Map<String, dynamic>> slotObjects = slots.map((slotStr) {
          final parts = (slotStr as String).split(' - ');
          return {
            'from': parts.length > 0 ? parts[0] : '',
            'to': parts.length > 1 ? parts[1] : '',
          };
        }).toList();
        
        return DateModel.fromJson({
          'name': day,
          'numberOfSlots': slots.length,
          'slots': slotObjects,
        });
      }).toList();
    }

    // Handle timings - may be null or empty
    List<TimingModel> timingList = [];
    if (json['timings'] != null) {
      var timingsFromJson = json['timings'] as List;
      timingList = timingsFromJson.map((i) => TimingModel.fromJson(i)).toList();
    } else if (json['timing'] != null) {
      // Handle 'timing' array from details endpoint
      var timingsFromJson = json['timing'] as List;
      timingList = timingsFromJson.map((i) => TimingModel.fromJson(i)).toList();
    }

    // Handle locations - may be null or empty
    List<LocationModel> locationList = [];
    if (json['locations'] != null) {
      var locationsFromJson = json['locations'] as List;
      locationList = locationsFromJson.map((i) => LocationModel.fromJson(i)).toList();
    }

    return SpecialistModel(
      id: json['id'],
      name: json['name'],
      image: json['image'] ?? json['profile_image'] ?? '',
      specialty: json['specialty'] ?? json['speciality'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      years: json['years'] ?? json['years_of_experience'] ?? 0,
      patients: json['patients'] ?? json['patients_treated'] ?? 0,
      appointment: appointment,
      dates: dateList,
      timings: timingList,
      locations: locationList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'specialty': specialty,
      'rating': rating,
      'years': years,
      'patients': patients,
      'appointment': appointment.toJson(),
      'dates': dates.map((date) => date.toJson()).toList(),
      'timings': timings.map((timing) => timing.toJson()).toList(),
      'locations': locations.map((location) => location.toJson()).toList(),
    };
  }

  SpecialistEntity toEntity() {
    return SpecialistEntity(
      id: id,
      name: name,
      image: image,
      specialty: specialty,
      rating: rating,
      years: years,
      patients: patients,
      appointment: appointment.toEntity(),
      dates: dates.map((date) => date.toEntity()).toList(),
      timings: timings.map((timing) => timing.toEntity()).toList(),
      locations: locations.map((location) => location.toEntity()).toList(),
    );
  }
}
