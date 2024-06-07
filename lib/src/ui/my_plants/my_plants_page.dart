import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:greenland/src/ui/my_plants/my_plant_widget.dart';
import 'package:greenland/api_service.dart';

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

  Future<void> _refreshPlants() async {
    setState(() {
      _plantsFuture = fetchPlants();
    });
  }

  void _deletePlant(String id) async {
    try {
      await deletePlant(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Plant deleted successfully')),
      );
      _refreshPlants();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting plant: $e')),
      );
    }
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
              maxCrossAxisExtent: 260,
              mainAxisSpacing: 50.0,
            ),
            itemCount: plants.length,
            itemBuilder: (context, index) {
              return MyPlantWidget(
                plant: plants[index],
                onDelete: () => _deletePlant(plants[index].id),
              );
            },
          );
        }
      },
    );
  }
}
