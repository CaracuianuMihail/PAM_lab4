import 'package:flutter/material.dart';
import 'package:lab2/presentation/screens/doctor_screen.dart';
import 'package:lab2/presentation/widgets/home_app_bar.dart';
import 'package:lab2/presentation/widgets/home_search.dart';
import 'package:lab2/presentation/widgets/card_with_image.dart';
import 'package:lab2/presentation/widgets/specialists_list.dart';
import 'package:lab2/presentation/widgets/specialties.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HomeSearch(),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CardWithImage(
                    imageUrl: "https://picsum.photos/350/250",
                    title: "Book Appointment",
                    height: 150,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CardWithImage(
                    imageUrl: "https://picsum.photos/351/250",
                    title: "Instant video consult",
                    height: 150,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CardWithImage(
                    imageUrl: "https://picsum.photos/200/150",
                    title: "Medicines",
                    height: 100,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CardWithImage(
                    imageUrl: "https://picsum.photos/201/150",
                    title: "Lab tests",
                    height: 100,
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: CardWithImage(
                    imageUrl: "https://picsum.photos/200/151",
                    title: "Emergencies",
                    height: 100,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Specialties most relevant to you",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SpecialtiesWidget(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Specialists",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorScreen(id: 1),
                        ),
                      );
                    },
                    child: const Text('View all >'),
                  ),
                ],
              ),
            ),
            SpecialistsList(),
          ],
        ),
      ),
    );
  }
}
