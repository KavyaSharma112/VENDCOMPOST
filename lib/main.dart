import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:vendcompost/screens/sensordata.dart';
import 'package:vendcompost/screens/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
