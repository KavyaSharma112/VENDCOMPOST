import 'package:flutter/material.dart';

import 'package:vendcompost/screens/splashscreen.dart.dart';

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
/*
New app features requirements:
 
Suggestive addition or subtraction of raw waste as to balance mineral values
 
Temperature sensing and using it to control power to geyser and water pump
 
Integration for gas sensor for gas production monitoring
 
Variable timing reminder to open valve / pull the flush on personal device to transfer stuff from upper container to lower.
 */