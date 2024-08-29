import 'package:flutter/material.dart';

class BmiStatusSection extends StatelessWidget {
  final String bmiStatus;
  final Color bmiStatusColor;

  const BmiStatusSection({
    super.key,
    required this.bmiStatus,
    required this.bmiStatusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      bmiStatus,
      style: TextStyle(fontSize: 20, color: bmiStatusColor),
    );
  }
}
