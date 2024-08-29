import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class GaugeSection extends StatelessWidget {
  final double bmiScore;
  final Color backgroundColor;

  const GaugeSection({
    super.key,
    required this.bmiScore,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Your Score",
          style: TextStyle(color: backgroundColor, fontSize: 30),
        ),
        const SizedBox(height: 10),
        PrettyGauge(
          gaugeSize: 300,
          minValue: 0,
          maxValue: 40,
          segments: [
            GaugeSegment('Under Weight', 18.5, Colors.red),
            GaugeSegment('Normal', 6.4, Colors.green),
            GaugeSegment('Over Weight', 5, Colors.orange),
            GaugeSegment('Obese', 10.1, Colors.pink),
          ],
          valueWidget: Text(
            bmiScore.toStringAsFixed(1),
            style: const TextStyle(fontSize: 50),
          ),
          currentValue: bmiScore.toDouble(),
          needleColor: backgroundColor,
        ),
      ],
    );
  }
}
