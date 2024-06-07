import 'package:flutter/material.dart';
import 'package:greenland/src/data/plant.dart';
import 'package:greenland/src/ui/today/today_date_widget.dart';
import 'package:greenland/src/ui/today/today_plant_widget.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({super.key});

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TodayDateWidget(),
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
        TodayPlantWidget(
          plant:
              Plant(id: '', image: '', nickname: 'Gordon', name: 'Sweatheart'),
        ),
      ],
    );
  }
}
