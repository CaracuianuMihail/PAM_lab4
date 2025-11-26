import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2/presentation/controllers/specialists_controller.dart';
import 'package:lab2/presentation/widgets/day_tab.dart';
import 'package:lab2/presentation/widgets/doctor_app_bar.dart';
import 'package:lab2/presentation/widgets/card_item.dart';
import 'package:lab2/presentation/widgets/slot_item.dart';
import 'package:lab2/presentation/widgets/stat_item.dart';
import 'package:lab2/presentation/widgets/tab_item.dart';

class DoctorScreen extends StatefulWidget {
  final int id;
  const DoctorScreen({super.key, required this.id});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final SpecialistsController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.selectedDateIndex.value = 0;
    
    // Load doctor data after the first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.selectDoctorById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final doctor = controller.selectedDoctor.value;

      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      if (controller.errorMessage.isNotEmpty) {
        return Scaffold(
          appBar: AppBar(title: Text('Error')),
          body: Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      }

      if (doctor == null) {
        return const Scaffold(body: Center(child: Text('Doctor not found')));
      }

      return Scaffold(
        appBar: DoctorAppBar(title: doctor.specialty),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(doctor.image),
                  ),
                  const SizedBox(width: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        doctor.specialty,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const Text(
                        'MBBS',
                        style: TextStyle(color: Colors.black38),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: StatItem(
                      icon: Icons.star,
                      value: doctor.rating.toString(),
                      label: 'Rating & Review',
                      iconColor: Colors.amber,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  Expanded(
                    child: StatItem(
                      icon: Icons.work,
                      value: doctor.years.toString(),
                      label: 'Years of work',
                      iconColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  Expanded(
                    child: StatItem(
                      icon: Icons.people,
                      value: doctor.patients.toString(),
                      label: 'No. of patients',
                      iconColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Tabs (Info / History / Review)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    TabItem(label: 'Info', selected: true),
                    VerticalDivider(width: 1),
                    TabItem(label: 'History', selected: false),
                    VerticalDivider(width: 1),
                    TabItem(label: 'Review', selected: false),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Appointment Card
              _buildAppointmentCard(context, doctor),

              if (doctor.timings.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Timing",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: doctor.timings
                        .map(
                          (time) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CardItem(title: time.day, subtitle: time.time),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
              if (doctor.locations.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Location",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: doctor.locations
                        .map(
                          (location) => Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CardItem(
                              title: location.city,
                              subtitle: location.location,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }

  Widget _buildAppointmentCard(BuildContext context, dynamic doctor) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            color: Theme.of(context).colorScheme.onPrimary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "In-Clinic Appointment",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${doctor.appointment.currency} ${doctor.appointment.fee}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.appointment.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      doctor.appointment.location,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const Text(
                      "2 More Clinic",
                      style: TextStyle(
                        color: Color(0xFF47BAFF),
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF47BAFF),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${doctor.appointment.durationMin} mins or less wait time",
                  style: const TextStyle(color: Colors.black45),
                ),
              ],
            ),
          ),
          Divider(color: Theme.of(context).colorScheme.outline),

          // Reactive date tabs
          Obx(
            () {
              final currentDoctor = controller.selectedDoctor.value;
              if (currentDoctor == null) return const SizedBox.shrink();
              
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(currentDoctor.dates.length, (index) {
                    final date = currentDoctor.dates[index];
                    final isSelected = index == controller.selectedDateIndex.value;
                    return GestureDetector(
                      onTap: () => controller.selectedDateIndex.value = index,
                      child: DayTab(
                        title: date.name,
                        info: "(${date.numberOfSlots == 0 ? "No" : date.numberOfSlots} slot)",
                        selected: isSelected,
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Slots
          Obx(() {
            final currentDoctor = controller.selectedDoctor.value;
            if (currentDoctor == null || currentDoctor.dates.isEmpty) {
              return const SizedBox.shrink();
            }
            
            final selectedDate = currentDoctor.dates[controller.selectedDateIndex.value];
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 14),
                  ...selectedDate.slots.map(
                    (slot) => SlotItem(time: '${slot.from} - ${slot.to}'),
                  ),
                  const SizedBox(width: 2),
                ],
              ),
            );
          }),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
