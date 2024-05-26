import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';

class TodayPlantWidget extends StatelessWidget {
  const TodayPlantWidget({required this.plant, super.key});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/plant.png', // Replace with your image asset path
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Gordon',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Sweatheart',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.water_drop,
                color: index < 3 ? Colors.blue : Colors.grey,
              );
            }),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {},
            child: Text('Done'),
          ),
        ],
      ),
    );
  }
}
