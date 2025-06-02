import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/circular_chart_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Circular Chart Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Circular Chart Examples'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PieChartExample()),
                );
              },
              child: const Text('Pie Chart Example'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RadialChartExample()),
                );
              },
              child: const Text('Radial Chart Example'),
            ),
          ],
        ),
      ),
    );
  }
}

class PieChartExample extends StatefulWidget {
  const PieChartExample({Key? key}) : super(key: key);

  @override
  PieChartExampleState createState() => PieChartExampleState();
}

class PieChartExampleState extends State<PieChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  List<CircularStackEntry>? _data;

  @override
  void initState() {
    super.initState();
    _data = _generateData();
  }

  List<CircularStackEntry> _generateData() {
    return [
      const CircularStackEntry(
        [
          CircularSegmentEntry(500.0, Colors.red, rankKey: 'Q1'),
          CircularSegmentEntry(300.0, Colors.green, rankKey: 'Q2'),
          CircularSegmentEntry(100.0, Colors.blue, rankKey: 'Q3'),
          CircularSegmentEntry(200.0, Colors.yellow, rankKey: 'Q4'),
        ],
        rankKey: 'Quarterly Sales',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pie Chart Example'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: _data!,
          chartType: CircularChartType.pie,
          edgeStyle: SegmentEdgeStyle.flat,
        ),
      ),
    );
  }
}

class RadialChartExample extends StatefulWidget {
  const RadialChartExample({Key? key}) : super(key: key);

  @override
  RadialChartExampleState createState() => RadialChartExampleState();
}

class RadialChartExampleState extends State<RadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);
  List<CircularStackEntry>? _data;
  double _value = 50.0;

  @override
  void initState() {
    super.initState();
    _data = _generateData(_value);
  }

  List<CircularStackEntry> _generateData(double value) {
    return [
      CircularStackEntry(
        [
          CircularSegmentEntry(value, Colors.blue, rankKey: 'progress'),
          CircularSegmentEntry(100.0 - value, Colors.blueGrey[200]!,
              rankKey: 'remaining'),
        ],
        rankKey: 'Progress',
      ),
    ];
  }

  void _updateData(double value) {
    setState(() {
      _value = value;
      _data = _generateData(_value);
      _chartKey.currentState?.updateData(_data!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Chart Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedCircularChart(
              key: _chartKey,
              size: _chartSize,
              initialChartData: _data!,
              chartType: CircularChartType.radial,
              edgeStyle: SegmentEdgeStyle.round,
              percentageValues: true,
              holeLabel: '${_value.toStringAsFixed(1)}%',
              labelStyle:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Slider(
            value: _value,
            min: 0.0,
            max: 100.0,
            onChanged: _updateData,
          ),
        ],
      ),
    );
  }
}

class SimpleChartExample extends StatefulWidget {
  const SimpleChartExample({super.key});

  @override
  SimpleChartExampleState createState() => SimpleChartExampleState();
}

class SimpleChartExampleState extends State<SimpleChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();

  final List<CircularStackEntry> data = <CircularStackEntry>[
    CircularStackEntry(
      <CircularSegmentEntry>[
        CircularSegmentEntry(
          500.0,
          Colors.red[200],
          rankKey: 'Q1',
        ),
        CircularSegmentEntry(
          1000.0,
          Colors.green[200],
          rankKey: 'Q2',
        ),
        CircularSegmentEntry(
          2000.0,
          Colors.blue[200],
          rankKey: 'Q3',
        ),
        CircularSegmentEntry(
          1000.0,
          Colors.yellow[200],
          rankKey: 'Q4',
        ),
      ],
      rankKey: 'Quarterly Profits',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Pie Chart'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: const Size(300.0, 300.0),
          initialChartData: data,
          chartType: CircularChartType.pie,
        ),
      ),
    );
  }
}

// Random Radial Chart Example
class RandomRadialChartExample extends StatefulWidget {
  const RandomRadialChartExample({super.key});

  @override
  State<RandomRadialChartExample> createState() =>
      _RandomRadialChartExampleState();
}

class _RandomRadialChartExampleState extends State<RandomRadialChartExample> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      GlobalKey<AnimatedCircularChartState>();
  final _chartSize = const Size(300.0, 300.0);

  List<CircularStackEntry> generateRandomData() {
    return <CircularStackEntry>[
      CircularStackEntry(
        <CircularSegmentEntry>[
          CircularSegmentEntry(
            (DateTime.now().millisecondsSinceEpoch % 100).toDouble(),
            Colors.red[400],
            rankKey: 'random',
          ),
        ],
        rankKey: 'random',
      ),
    ];
  }

  void _randomize() {
    _chartKey.currentState!.updateData(generateRandomData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Radial Chart Example'),
      ),
      body: Center(
        child: AnimatedCircularChart(
          key: _chartKey,
          size: _chartSize,
          initialChartData: generateRandomData(),
          chartType: CircularChartType.radial,
          percentageValues: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _randomize,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
