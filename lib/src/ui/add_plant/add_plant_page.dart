import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:greenland/src/ui/add_plant/add_reminder_widget.dart';
import 'package:greenland/src/ui/my_plants/my_plant_widget.dart';

import 'add_plant_widget.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              'New plant',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
        Row(
          children: [
            AddPlantWidget(
              plant: Plant(image: '', nickname: 'Gordon', name: 'Sweatheart'),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              'Reminders',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                indent: 10,
                endIndent: 50,
                color: Colors.black,
              ),
            ),
          ],
        ),
        AddReminderWidget(
          plant: Plant(image: '', nickname: 'Gordon', name: 'Sweatheart'),
        ),
      ],
    );
  }
}
