import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2/presentation/controllers/specialties_controller.dart';
import 'package:lab2/presentation/utils/icon_mapper.dart';
import 'package:lab2/presentation/widgets/round_icon.dart';

class SpecialtiesWidget extends StatelessWidget {
  SpecialtiesWidget({super.key});

  final SpecialtiesController controller = Get.find<SpecialtiesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Text("Loading...");
      }

      if (controller.errorMessage.isNotEmpty) {
        return Text(
          "Error: ${controller.errorMessage.value}",
          style: const TextStyle(color: Colors.red),
        );
      }

      final specialties = controller.specialties;

      return Row(
        children: specialties
            .map(
              (specialty) => RoundIcon(
                icon: IconMapper.getIconForSpecialty(specialty.icon),
                text: specialty.name,
              ),
            )
            .toList(),
      );
    });
  }
}
