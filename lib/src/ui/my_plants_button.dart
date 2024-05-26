import 'package:flutter/material.dart';
//import 'package:greenland/src/ui/my_plants_page.dart';  // Replace with your my plants page path
import 'package:greenland/src/config/styles/palette.dart';

class MyPlantsButton extends StatelessWidget {
  const MyPlantsButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Palette.backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.space_dashboard_outlined,
              color: Colors.black,
            ),
            SizedBox(width: 8),
            Text('My Plants'),
          ],
        ),
      ),
    );
  }
}
