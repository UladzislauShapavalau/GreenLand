import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:greenland/src/ui/my_plants/my_plant_widget.dart';
import 'package:greenland/api_service.dart'; // Импортируйте созданный api_service

class MyPlantsPage extends StatefulWidget {
  const MyPlantsPage({super.key});

  @override
  State<MyPlantsPage> createState() => _MyPlantsPageState();
}

class _MyPlantsPageState extends State<MyPlantsPage> {
  late Future<List<Plant>> _plantsFuture;

  @override
  void initState() {
    super.initState();
    _plantsFuture = fetchPlants();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plant>>(
      future: _plantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching plants'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No plants available'));
        } else {
          final plants = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //crossAxisCount: 6,
              maxCrossAxisExtent: 260,
              //crossAxisSpacing: ,
              mainAxisSpacing: 50.0,
            ),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              return MyPlantWidget(plant: plants[index]);
            },
          );
        }
      },
    );
  }
}
