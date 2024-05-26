import 'package:flutter/material.dart';
import 'package:greenland/src/ui/today_button.dart'; // Import your button widgets
import 'package:greenland/src/ui/my_plants_button.dart';
import 'package:greenland/src/ui/add_plants_button.dart';
import 'package:greenland/src/config/styles/palette.dart';

class MainLeftWidget extends StatelessWidget {
  const MainLeftWidget({required this.onTap, super.key});

  final Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Palette.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          TodayButton(onTap: () => onTap(0)),
          MyPlantsButton(onTap: () => onTap(1)),
          const SizedBox(height: 16),
          AddPlantsButton(onTap: () => onTap(2)),
          const Spacer(),
        ],
      ),
    );
  }
}
