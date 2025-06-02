import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';
import 'dart:math' as math;

import 'color_palette.dart';

void main() {
  runApp(const MaterialApp(
    home: RandomizedRadialChartExample(),
  ));
}

class RandomizedRadialChartExample extends StatefulWidget {
  const RandomizedRadialChartExample({super.key});

  @override
  RandomizedRadialChartExampleState createState() =>
      RandomizedRadialChartExampleState();
}

class RandomizedRadialChartExampleState
    extends State<RandomizedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  final math.Random random = math.Random();
  List<CircularStackEntry>? data;

  @override
  void initState() {
    super.initState();
    data = _generateRandomData();
  }

  double value = 50.0;

  void _randomize() {
    setState(() {
      data = _generateRandomData();
      _chartKey.currentState!.updateData(data!);
    });
  }

  List<CircularStackEntry> _generateRandomData() {
    int stackCount = random.nextInt(10);
    List<CircularStackEntry> data = List.generate(stackCount, (i) {
      int segCount = random.nextInt(10);
      List<CircularSegmentEntry> segments = List.generate(segCount, (j) {
        Color? randomColor = ColorPalette.primary.random(random);
        return CircularSegmentEntry(random.nextDouble(), randomColor);
      });
      return CircularStackEntry(segments);
    });

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomized radial data'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: data,
          chartType: CircularChartType.radial,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomize,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
