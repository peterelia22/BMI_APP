import 'package:flutter/material.dart';
import '../utils/assets.dart';

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
  void _incrementWeight() {
    setState(() {
      widget.onChanged(widget.weight + 1);
    });
  }

  void _decrementWeight() {
    setState(() {
      if (widget.weight > 0) {
        widget.onChanged(widget.weight - 1);
      }
    });
  }

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
        Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _decrementWeight,
                icon: Icon(Icons.remove),
                color: widget.isWeightSelected ? Assets.pColor : Colors.red,
              ),
            ),
            Expanded(
              flex: 9,
              child: Slider(
                value: widget.weight.toDouble(),
                min: 0,
                max: 300,
                divisions: 300,
                activeColor:
                    widget.isWeightSelected ? Assets.pColor : Colors.red,
                label: "${widget.weight} Kg",
                onChanged: (double newValue) {
                  widget.onChanged(newValue.toInt());
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _incrementWeight,
                icon: Icon(Icons.add),
                color: widget.isWeightSelected ? Assets.pColor : Colors.red,
              ),
            ),
          ],
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
