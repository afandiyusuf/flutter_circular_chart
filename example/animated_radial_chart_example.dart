import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';

void main() {
  runApp(const MaterialApp(
    home: AnimatedRadialChartExample(),
  ));
}

class AnimatedRadialChartExample extends StatefulWidget {
  const AnimatedRadialChartExample({super.key});

  @override
  AnimatedRadialChartExampleState createState() =>
      AnimatedRadialChartExampleState();
}

class AnimatedRadialChartExampleState
    extends State<AnimatedRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(200.0, 200.0);

  double value = 50.0;
  Color? labelColor = Colors.blue[200];

  void _increment() {
    setState(() {
      value += 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState!.updateData(data);
    });
  }

  void _decrement() {
    setState(() {
      value -= 10;
      List<CircularStackEntry> data = _generateChartData(value);
      _chartKey.currentState!.updateData(data);
    });
  }

  List<CircularStackEntry> _generateChartData(double value) {
    Color? dialColor = Colors.blue[200];
    if (value < 0) {
      dialColor = Colors.red[200];
    } else if (value < 50) {
      dialColor = Colors.yellow[200];
    }
    labelColor = dialColor;

    List<CircularStackEntry> data = <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value,
            dialColor,
            rankKey: 'percentage',
          )
        ],
        rankKey: 'percentage',
      ),
    ];

    if (value > 100) {
      labelColor = Colors.green[200];

      data.add(CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            value - 100,
            Colors.green[200],
            rankKey: 'percentage',
          ),
        ],
        rankKey: 'percentage2',
      ));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = Theme.of(context)
        .textTheme
        .displayLarge!
        .merge(TextStyle(color: labelColor));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Percentage Dial'),
      ),
      body: Column(
        children: <Widget>[
          AnimatedCircularChart(
            key: _chartKey,
            size: _chartSize,
            initialChartData: _generateChartData(value),
            chartType: CircularChartType.radial,
            edgeStyle: SegmentEdgeStyle.round,
            percentageValues: true,
            holeLabel: '$value%',
            labelStyle: labelStyle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: _decrement,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red[200],
                  shape: const CircleBorder(), // text color
                ),
                child: const Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: _increment,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue[200],
                  shape: const CircleBorder(), // text color
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
