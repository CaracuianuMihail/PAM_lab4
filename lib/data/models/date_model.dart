import 'package:lab2/data/models/slot_model.dart';
import 'package:lab2/domain/entities/date_entity.dart';

class DateModel {
  final String name;
  final int numberOfSlots;
  final List<SlotModel> slots;

  DateModel({
    required this.name,
    required this.numberOfSlots,
    required this.slots,
  });

  factory DateModel.fromJson(Map<String, dynamic> json) {
    var slotsFromJson = json['slots'] as List? ?? [];
    List<SlotModel> slotList =
        slotsFromJson.map((i) => SlotModel.fromJson(i)).toList();

    return DateModel(
      name: json['name'] ?? '',
      numberOfSlots: json['numberOfSLots'] ?? json['numberOfSlots'] ?? slotList.length,
      slots: slotList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'numberOfSLots': numberOfSlots,
      'slots': slots.map((slot) => slot.toJson()).toList(),
    };
  }

  DateEntity toEntity() {
    // Parse name to extract day and month
    final parts = name.split(' ');
    return DateEntity(
      name: name,
      numberOfSlots: numberOfSlots,
      slots: slots.map((slot) => slot.toEntity()).toList(),
      day: parts.isNotEmpty ? int.tryParse(parts[0]) ?? 0 : 0,
      month: parts.length > 1 ? parts[1] : '',
    );
  }
}
