class AppointmentEntity {
  final double fee;
  final String currency;
  final int durationMin;
  final String name;
  final String location;
  final String date;
  final String time;

  AppointmentEntity({
    required this.fee,
    required this.currency,
    required this.durationMin,
    required this.name,
    required this.location,
    required this.date,
    required this.time,
  });
}
