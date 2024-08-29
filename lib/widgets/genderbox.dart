import 'package:flutter/material.dart';
import 'package:flutter_3d_choice_chip/flutter_3d_choice_chip.dart';

import '../utils/assets.dart';

class Gender extends StatefulWidget {
  final Function(int) onChanged;
  final bool isGenderSelected; // New parameter to track selection status

  const Gender({
    super.key,
    required this.onChanged,
    required this.isGenderSelected,
  });

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  int _gender = 0;

  @override
  Widget build(BuildContext context) {
    bool isGenderSelected = widget.isGenderSelected;

    Color chipColor =
        !isGenderSelected && _gender == 0 ? Colors.red : Colors.white;
    Color borderColor =
        !isGenderSelected && _gender == 0 ? Colors.red : Colors.grey;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceChip3D(
            border: Border.all(color: borderColor),
            style: ChoiceChip3DStyle(
              topColor: Colors.white,
              backColor: !isGenderSelected && _gender == 0
                  ? chipColor
                  : Assets.maleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: () {
              setState(() {
                _gender = 1;
                widget.onChanged(_gender);
              });
            },
            onUnSelected: () {},
            selected: _gender == 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Image.asset(
                    Assets.assetsImagesMale,
                    width: 50,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Male',
                  style: TextStyle(
                    color: Assets.maleColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          ChoiceChip3D(
            border: Border.all(color: borderColor),
            style: ChoiceChip3DStyle(
              topColor: Colors.white,
              backColor: !isGenderSelected && _gender == 0
                  ? chipColor
                  : Assets.femaleColor,
              borderRadius: BorderRadius.circular(20),
            ),
            onSelected: () {
              setState(() {
                _gender = 2;
                widget.onChanged(_gender);
              });
            },
            onUnSelected: () {},
            selected: _gender == 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Image.asset(
                    Assets.assetsImagesFemale,
                    width: 50,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Female',
                  style: TextStyle(
                    color: Assets.femaleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
