import 'package:flutter/material.dart';

import '../../../models/path_sketch.dart';
import '../../widgets/sketch_painter.dart';

class PainterContainer extends StatefulWidget {
  const PainterContainer({
    super.key,
    required this.isFill,
  });

  final bool isFill;

  @override
  State<PainterContainer> createState() => _PainterContainerState();
}

class _PainterContainerState extends State<PainterContainer>
    with SingleTickerProviderStateMixin {
  late PathSketch currentSketch;
  late AnimationController controller;
  late Path path;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..drive(CurveTween(curve: Curves.easeOut));

    // Just to prevent multiple null checks
    currentSketch = PathSketch(points: []);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        // Stop any ongoing animation
        controller.reset();

        final renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.globalToLocal(details.position);

        setState(() {
          currentSketch = PathSketch(points: [offset]);
        });
      },
      onPointerMove: (details) {
        final renderBox = context.findRenderObject() as RenderBox;
        final offset = renderBox.globalToLocal(details.position);

        /// Getting the points value of the currentSketch, make a list from the previous value
        /// Then adding the new offset to the list value
        /// Finally, update the ui state with setState and creating a new [PathSketch]
        ///
        /// TODO: Try explore an example with Flutter hooks for ephemeral state
        final points = List<Offset>.from(currentSketch.points)..add(offset);
        setState(() {
          currentSketch = PathSketch(points: points);
        });
      },
      onPointerUp: (details) {
        // Start the animation
        controller.forward();
      },
      child: RepaintBoundary(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return CustomPaint(
                painter: SketchPainter(
                  sketch: currentSketch,
                  isFill: widget.isFill,
                  animationValue: controller.value,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
