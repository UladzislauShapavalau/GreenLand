import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('New plant'),
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
        ],
      ),
    );
  }
}
