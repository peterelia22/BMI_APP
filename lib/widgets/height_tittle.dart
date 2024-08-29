import 'package:bmi/utils/assets.dart';
import 'package:flutter/material.dart';

class HeightTitle extends StatelessWidget {
  final bool isHeightSelected;
  final int height;

  const HeightTitle({
    super.key,
    required this.isHeightSelected,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Height',
          style: TextStyle(
            color: isHeightSelected ? Assets.pColor : Colors.red,
            fontSize: 25,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              height.toString(),
              style: TextStyle(
                color: isHeightSelected ? Assets.pColor : Colors.red,
                fontSize: 40,
              ),
            ),
            Text(
              'cm',
              style: TextStyle(
                fontSize: 20,
                color: isHeightSelected ? Assets.pColor : Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
