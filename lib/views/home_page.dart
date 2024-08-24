import 'package:bmi/widgets/age_and_weight.dart';
import 'package:bmi/widgets/height.dart';
import 'package:flutter/material.dart';

import '../widgets/genderbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _gender = 0;
  int _height = 100;
  int _age = 20;
  int _weight = 40;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'BMI Calculator',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Gender(
                  onChanged: (genderVal) {
                    _gender = genderVal;
                  },
                ),
                Height(
                  onChanged: (heightVal) {
                    _height = heightVal;
                  },
                ),
                Row(
                  children: [
                    AgeAndWeight(
                      title: "Age",
                      onChange: (ageVal) {
                        _age = ageVal;
                      },
                      min: 0,
                      max: 120,
                      initValue: 20,
                    ),
                    AgeAndWeight(
                      title: "Weight  (Kg)",
                      onChange: (weightVal) {
                        _weight = weightVal;
                      },
                      min: 0,
                      max: 300,
                      initValue: 50,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
