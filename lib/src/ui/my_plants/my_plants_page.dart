import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:greenland/src/ui/my_plants/my_plant_widget.dart';

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({super.key});

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Bedroom'),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  endIndent: 50,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          MyPlantWidget(
            plant: Plant(image: '', nickname: 'Gordon', name: 'Sweatheart'),
          ),
        ],
      ),
    );
  }
}
