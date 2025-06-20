import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';
import 'package:circular_chart_flutter/src/entry.dart';
import 'package:circular_chart_flutter/src/segment.dart';
import 'package:circular_chart_flutter/src/tween.dart';

const double _kMaxAngle = 360.0;

class CircularChartStack implements MergeTweenable<CircularChartStack> {
  CircularChartStack(
    this.rank,
    this.radius,
    this.width,
    this.startAngle,
    this.segments,
  );

  final int rank;
  final double? radius;
  final double? width;
  final double? startAngle;
  final List<CircularChartSegment> segments;

  factory CircularChartStack.fromData(
    int stackRank,
    List<CircularSegmentEntry> entries,
    Map<String?, int>? entryRanks,
    bool percentageValues,
    double startRadius,
    double stackWidth,
    double startAngle,
  ) {
    final double valueSum = percentageValues
        ? 100.0
        : entries.fold(
            0.0,
            (double prev, CircularSegmentEntry element) => prev + element.value,
          );

    double previousSweepAngle = 0.0;
    List<CircularChartSegment> segments =
        List<CircularChartSegment>.generate(entries.length, (i) {
      double sweepAngle =
          (entries[i].value / valueSum * _kMaxAngle) + previousSweepAngle;
      previousSweepAngle = sweepAngle;
      int rank = entryRanks![entries[i].rankKey] ?? i;
      return CircularChartSegment(rank, sweepAngle, entries[i].color);
    });

    return CircularChartStack(
      stackRank,
      startRadius,
      stackWidth,
      startAngle,
      segments.reversed.toList(),
    );
  }

  @override
  CircularChartStack get empty => CircularChartStack(
      rank, radius, 0.0, startAngle, <CircularChartSegment>[]);

  @override
  bool operator <(CircularChartStack other) => rank < other.rank;

  @override
  Tween<CircularChartStack> tweenTo(CircularChartStack other) =>
      CircularChartStackTween(this, other);
}

class CircularChartStackTween extends Tween<CircularChartStack> {
  CircularChartStackTween(CircularChartStack begin, CircularChartStack end)
      : _circularSegmentsTween =
            MergeTween<CircularChartSegment>(begin.segments, end.segments),
        super(begin: begin, end: end) {
    assert(begin.rank == end.rank);
  }

  final MergeTween<CircularChartSegment> _circularSegmentsTween;

  @override
  CircularChartStack lerp(double t) => CircularChartStack(
        begin!.rank,
        lerpDouble(begin!.radius, end!.radius, t),
        lerpDouble(begin!.width, end!.width, t),
        lerpDouble(begin!.startAngle, end!.startAngle, t),
        _circularSegmentsTween.lerp(t),
      );
}
