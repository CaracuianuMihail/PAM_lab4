import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2/presentation/controllers/profile_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  HomeAppBar({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

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
          title: const Text(
            'Error loading profile',
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      final profile = controller.profile.value!;
      return PreferredSize(
        preferredSize: preferredSize,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            elevation: 0,
            leadingWidth: 80,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(profile.imageUrl),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(profile.name),
                const SizedBox(height: 2),
                Text(
                  profile.location,
                  style: const TextStyle(fontSize: 12, color: Colors.black26),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
                iconSize: 30,
                style: IconButton.styleFrom(side: BorderSide.none),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      );
    });
  }
}
