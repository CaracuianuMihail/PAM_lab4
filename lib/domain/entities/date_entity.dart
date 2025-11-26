import 'package:lab2/domain/entities/slot_entity.dart';

class DateEntity {
  final String name;
  final int numberOfSlots;
  final List<SlotEntity> slots;
  final int day;
  final String month;

  DateEntity({
    required this.name,
    required this.numberOfSlots,
    required this.slots,
    required this.day,
    required this.month,
  });
}
