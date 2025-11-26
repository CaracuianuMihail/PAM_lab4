// specialists_list.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2/presentation/screens/doctor_screen.dart';
import 'package:lab2/presentation/widgets/card_with_image_like.dart';
import 'package:lab2/presentation/controllers/specialists_controller.dart';

class SpecialistsList extends StatelessWidget {
  SpecialistsList({super.key});

  final SpecialistsController controller = Get.find<SpecialistsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox(
          height: kToolbarHeight + 10,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return AppBar(
          title: Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      final specialists = controller.specialists;

      return SizedBox(
        height: 300,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: specialists.length,
          itemBuilder: (context, index) {
            final specialist = specialists[index];
            return CardWithImageLike(
              imageUrl: specialist.image,
              title: specialist.name,
              height: 300,
              width: 300,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DoctorScreen(id: specialist.id),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        ),
      );
    });
  }
}
