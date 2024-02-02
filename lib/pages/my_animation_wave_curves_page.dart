//set this class to home of material app in main.dart
import 'package:flutter/material.dart';
import 'package:wave/widgets/waves_widget.dart';

class MyAnimatedWaveCurvesPage extends StatefulWidget {
  const MyAnimatedWaveCurvesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAnimatedWavesCurves();
  }
}

class _MyAnimatedWavesCurves extends State<MyAnimatedWaveCurvesPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: WavesWidget(),
      ),
    );
  }
}
