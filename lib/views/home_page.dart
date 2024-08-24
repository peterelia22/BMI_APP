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
                Height()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
