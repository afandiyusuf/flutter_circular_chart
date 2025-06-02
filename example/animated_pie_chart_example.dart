import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: AnimatedPieChartExample(),
  ));
}

final List<List<CircularStackEntry>> _quarterlyProfitPieData = [
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(500.0, Colors.red[200], rankKey: 'Q1'),
        CircularSegmentEntry(1000.0, Colors.green[200], rankKey: 'Q2'),
        CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(1500.0, Colors.red[200], rankKey: 'Q1'),
        CircularSegmentEntry(750.0, Colors.green[200], rankKey: 'Q2'),
        CircularSegmentEntry(2000.0, Colors.blue[200], rankKey: 'Q3'),
        CircularSegmentEntry(1000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
  <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(1800.0, Colors.red[200], rankKey: 'Q1'),
        CircularSegmentEntry(2900.0, Colors.green[200], rankKey: 'Q2'),
        CircularSegmentEntry(4000.0, Colors.blue[200], rankKey: 'Q3'),
        CircularSegmentEntry(7000.0, Colors.yellow[200], rankKey: 'Q4'),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ],
];

class AnimatedPieChartExample extends StatefulWidget {
  const AnimatedPieChartExample({super.key});

  @override
  AnimatedPieChartExampleState createState() => AnimatedPieChartExampleState();
}

class AnimatedPieChartExampleState extends State<AnimatedPieChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  int sampleIndex = 0;

  void _cycleSamples() {
    setState(() {
      sampleIndex++;
      List<CircularStackEntry> data = _quarterlyProfitPieData[sampleIndex % 3];
      _chartKey.currentState!.updateData(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quarterly Profit'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: _quarterlyProfitPieData[0],
          chartType: CircularChartType.pie,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _cycleSamples,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
