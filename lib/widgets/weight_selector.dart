import 'package:bmi/utils/assets.dart';
import 'package:flutter/material.dart';

class WeightSelector extends StatefulWidget {
  final int weight;
  final Function(int) onChanged;
  final bool isWeightSelected;

  const WeightSelector({
    Key? key,
    required this.weight,
    required this.onChanged,
    required this.isWeightSelected,
  }) : super(key: key);

  @override
  _WeightSelectorState createState() => _WeightSelectorState();
}

class _WeightSelectorState extends State<WeightSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weight (Kg)",
          style: TextStyle(
            color: widget.isWeightSelected ? Assets.pColor : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: widget.weight.toDouble(),
          min: 0,
          max: 300,
          divisions: 300,
          activeColor: widget.isWeightSelected ? Assets.pColor : Colors.red,
          label: "${widget.weight} Kg",
          onChanged: (double newValue) {
            widget.onChanged(newValue.toInt());
          },
        ),
        Text(
          '${widget.weight} Kg',
          style: TextStyle(
            color: widget.isWeightSelected ? Assets.pColor : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
