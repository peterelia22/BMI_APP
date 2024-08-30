import 'package:flutter/material.dart';
import '../utils/assets.dart';

class AgeSelector extends StatefulWidget {
  final int age;
  final Function(int?) onChanged;
  final bool isAgeSelected;

  const AgeSelector({
    super.key,
    required this.age,
    required this.onChanged,
    required this.isAgeSelected,
  });

  @override
  _AgeSelectorState createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  void _incrementAge() {
    setState(() {
      widget.onChanged(widget.age + 1);
    });
  }

  void _decrementAge() {
    setState(() {
      if (widget.age > 0) {
        widget.onChanged(widget.age - 1);
      }
    });
  }

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
        Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _decrementAge,
                icon: Icon(Icons.remove),
                color: widget.isAgeSelected ? Assets.pColor : Colors.red,
              ),
            ),
            Expanded(
              flex: 9,
              child: Slider(
                value: widget.age.toDouble(),
                min: 0,
                max: 120,
                divisions: 120,
                activeColor: widget.isAgeSelected ? Assets.pColor : Colors.red,
                label: "${widget.age} Years",
                onChanged: (double newValue) {
                  widget.onChanged(newValue.toInt());
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: _incrementAge,
                icon: Icon(Icons.add),
                color: widget.isAgeSelected ? Assets.pColor : Colors.red,
              ),
            ),
          ],
        ),
        Text(
          '${widget.age} Years',
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
