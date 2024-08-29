import 'package:bmi/utils/assets.dart';
import 'package:flutter/material.dart';

class AgeSelector extends StatefulWidget {
  final int? age;
  final Function(int?) onChanged;
  final bool isAgeSelected;

  const AgeSelector({
    super.key,
    this.age,
    required this.onChanged,
    required this.isAgeSelected,
  });

  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Age",
          style: TextStyle(
            color: widget.isAgeSelected ? Assets.pColor : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: widget.age?.toDouble() ?? 0.0,
          min: 0,
          max: 120,
          divisions: 120,
          activeColor: widget.isAgeSelected ? Assets.pColor : Colors.red,
          label: "${widget.age ?? 0} Years",
          onChanged: (double newValue) {
            widget.onChanged(newValue.toInt());
          },
        ),
        Text(
          '${widget.age ?? 0} Years',
          style: TextStyle(
            color: widget.isAgeSelected ? Assets.pColor : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
