import 'package:flutter/material.dart';
import 'package:greenland/src/config/styles/palette.dart';
import 'package:greenland/src/ui/main_left_widget.dart';

import 'package:greenland/src/ui/add_plant/add_plant_page.dart';
import 'package:greenland/src/ui/my_plants/my_plants_page.dart';
import 'package:greenland/src/ui/today/today_page.dart';
import 'package:greenland/src/ui/error_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/ui/auth/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: AuthPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //surfaceTintColor: Palette.backgroundColor,
        backgroundColor: Palette.backgroundColor,
        toolbarHeight: 80,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('icons/icon_logo.png'),
            const SizedBox(width: 8),
            const Text('Greenland'),
            const Spacer(
              flex: 20,
            ),
            const Icon(
              Icons.mail_outline,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.notifications_none_outlined,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            Container(
              width: 1,
              height: 24,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.person_outline,
              color: Colors.black87,
            ),
            const SizedBox(width: 8),
            Text(AuthPageState.username.split('@').first),
            Spacer(),
          ],
        ),
      ),
      body: Row(
        children: [
          Flexible(
            child: MainLeftWidget(
              onTap: (index) => setState(() {
                pageIndex = index;
              }),
            ),
          ),
          Flexible(
              flex: 7,
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 100),
                child: switch (pageIndex) {
                  0 => TodayPage(),
                  1 => MyPlantsPage(),
                  2 => AddPlantPage(),
                  _ => ErrorPage()
                },
              )),
        ],
      ),
    );
  }
}
