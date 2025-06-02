import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/src/animated_circular_chart.dart';
import 'package:circular_chart_flutter/src/entry.dart';
import 'package:circular_chart_flutter/src/stack.dart';
import 'package:circular_chart_flutter/src/tween.dart';

class CircularChart {
  static const double _kStackWidthFraction = 0.75;

  CircularChart(
    this.stacks,
    this.chartType, {
    this.edgeStyle = SegmentEdgeStyle.flat,
  });

  final List<CircularChartStack> stacks;
  final CircularChartType chartType;
  final SegmentEdgeStyle? edgeStyle;

  factory CircularChart.empty({required CircularChartType chartType}) {
    return CircularChart(<CircularChartStack>[], chartType);
  }

  factory CircularChart.fromData({
    required Size size,
    required List<CircularStackEntry> data,
    required CircularChartType chartType,
    required bool percentageValues,
    required double startAngle,
    Map<String?, int>? stackRanks,
    Map<String?, int>? entryRanks,
    double? holeRadius,
    SegmentEdgeStyle? edgeStyle,
  }) {
    final double holeRad = holeRadius ?? size.width / (2 + data.length);
    final double stackDistance = (size.width / 2 - holeRad) / (2 + data.length);
    final double stackWidth = stackDistance * _kStackWidthFraction;
    final double startRadius = stackDistance + holeRad;

    List<CircularChartStack> stacks = List<CircularChartStack>.generate(
      data.length,
      (i) => CircularChartStack.fromData(
        stackRanks![data[i].rankKey] ?? i,
        data[i].entries,
        entryRanks,
        percentageValues,
        startRadius + i * stackDistance,
        stackWidth,
        startAngle,
      ),
    );

    return CircularChart(stacks, chartType, edgeStyle: edgeStyle);
  }
}

class CircularChartTween extends Tween<CircularChart> {
  CircularChartTween(CircularChart begin, CircularChart end)
      : _stacksTween = MergeTween<CircularChartStack>(begin.stacks, end.stacks),
        super(begin: begin, end: end);

  final MergeTween<CircularChartStack> _stacksTween;

  @override
  CircularChart lerp(double t) => CircularChart(
        _stacksTween.lerp(t),
        begin!.chartType,
        edgeStyle: end!.edgeStyle,
      );
}
