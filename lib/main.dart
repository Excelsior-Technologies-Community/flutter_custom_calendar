import 'package:custom_calendar/custom_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_calendar/custom_calendar/custom_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  New(),
    );
  }
}

class New extends StatelessWidget {
  const New({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          CustomCalendar(
            events: {
              DateTime(2026, 1, 15): ["Meeting"],
              DateTime(2026, 1, 20): ["Birthday"],
            },
            holidays: {
              DateTime(2026, 1, 26): "Republic Day",
              DateTime(2026, 1, 14): "Makar Sankranti",
            },
          )
        ],
      ),
    );
  }
}

