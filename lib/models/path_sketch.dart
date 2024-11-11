import 'package:flutter/material.dart';

class PathSketch {
  final List<Offset> points;

  final Color color;

  final double size;

  PathSketch({
    required this.points,
    this.color = Colors.white,
    this.size = 4,
  });
}
