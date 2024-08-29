import 'package:flutter/material.dart';

class DietAdviceSection extends StatelessWidget {
  final String dietAdvice;
  final Color backgroundColor;

  const DietAdviceSection({
    super.key,
    required this.dietAdvice,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      dietAdvice,
      style: TextStyle(fontSize: 15, color: backgroundColor),
    );
  }
}
