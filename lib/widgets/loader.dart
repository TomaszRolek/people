import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: GradientProgressIndicator(
          radius: 20,
          strokeWidth: 6,
          duration: 1,
          gradientStops: [0.0, 1.0],
          gradientColors: [Colors.black, Colors.blue],
          child: Text(''),
        ),
      ),
    );
  }
}
