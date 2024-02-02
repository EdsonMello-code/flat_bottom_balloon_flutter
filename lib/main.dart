import 'package:flutter/material.dart';
import 'package:wave/pages/my_animation_wave_curves_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAnimatedWaveCurvesPage(),
    );
  }
}
