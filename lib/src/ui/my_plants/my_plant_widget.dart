import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({required this.plant, super.key});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 230,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    child: SizedBox(
                      width: 160,
                      height: 160,
                    ),
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/icons/plant_sweat.png',
                          width: 130,
                          height: 130,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant.nickname,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            plant.name,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.0),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}
