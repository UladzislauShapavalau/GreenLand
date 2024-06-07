import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';

class MyPlantWidget extends StatelessWidget {
  const MyPlantWidget({required this.plant, required this.onDelete, super.key});

  final Plant plant;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> imageProvider;

    try {
      Uint8List imageBytes = base64Decode(plant.image);
      imageProvider = MemoryImage(imageBytes);
    } catch (e) {
      print('Error decoding Base64 image: $e');
      imageProvider = AssetImage('assets/icons/plant_sweat.png');
    }

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
                      child: Image(
                        image: imageProvider,
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
                          GestureDetector(
                            onTap: onDelete,
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            ),
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
