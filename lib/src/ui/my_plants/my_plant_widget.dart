import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({required this.plant, super.key});

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 260,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                    width: 180,
                    height: 220,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: plant.image.isNotEmpty
                          ? Image.network(
                              plant.image,
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/icons/plant_sweat.png',
                              width: 140,
                              height: 140,
                              fit: BoxFit.cover,
                            ),
                    ),
                    SizedBox(height: 6.0),
                    SizedBox(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plant.nickname,
                                style: TextStyle(
                                  fontSize: 16.0,
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
                            ],
                          ),
                          Icon(
                            Icons.info,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
