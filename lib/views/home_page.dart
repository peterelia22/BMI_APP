import 'dart:core';
import 'dart:math';

import 'package:bmi/utils/assets.dart';
import 'package:bmi/views/result_page.dart';
import 'package:bmi/widgets/height.dart';
import 'package:bmi/widgets/social_media_accounts.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import '../widgets/age_selector.dart';
import '../widgets/genderbox.dart';
import '../widgets/weight_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _gender;
  int? _height;
  int? _age;
  int? _weight;

  bool _isFinished = false;
  bool _isAgeSelected = true;
  bool _isHeightSelected = true;
  bool _isWeightSelected = true;
  bool _isGenderSelected = true;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Assets.pColor,
        centerTitle: true,
        title: const Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Gender(
                  onChanged: (genderVal) {
                    setState(() {
                      _gender = genderVal;
                      _isGenderSelected = true;
                    });
                  },
                  isGenderSelected: _isGenderSelected,
                ),
                const SizedBox(height: 30),
                Height(
                  onChanged: (heightVal) {
                    setState(() {
                      _height = heightVal;
                      _isHeightSelected = true;
                    });
                  },
                  isHeightSelected: _isHeightSelected,
                  height: _height ?? 0,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: AgeSelector(
                        age: _age,
                        onChanged: (newValue) {
                          setState(() {
                            _age = newValue;
                            _isAgeSelected = true;
                          });
                        },
                        isAgeSelected: _isAgeSelected,
                      ),
                    ),
                    Flexible(
                      child: WeightSelector(
                        weight: _weight ?? 0,
                        onChanged: (weightVal) {
                          setState(() {
                            _weight = weightVal;
                            _isWeightSelected = true;
                          });
                        },
                        isWeightSelected: _isWeightSelected,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                    onFinish: () async {
                      switch (_gender) {
                        case 0:
                        case null:
                          setState(() {
                            _isFinished = false;
                            _isGenderSelected = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your gender.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                      }

                      switch (_height) {
                        case null:
                        case 0:
                          setState(() {
                            _isFinished = false;
                            _isHeightSelected = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your height.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                      }

                      switch (_age) {
                        case null:
                          setState(() {
                            _isFinished = false;
                            _isAgeSelected = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your age.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                      }

                      switch (_weight) {
                        case null:
                        case 0:
                          setState(() {
                            _isFinished = false;
                            _isWeightSelected = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select your weight.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                      }

                      final result = await Navigator.push(
                        context,
                        PageTransition(
                          child: ResultPage(
                            bmiScore: _bmiScore,
                            age: _age!,
                            gender: _gender!,
                          ),
                          type: PageTransitionType.fade,
                        ),
                      );

                      if (result == true) {
                        _resetValues();
                      }

                      setState(() {
                        _isFinished = false;
                      });
                    },
                    onWaitingProcess: () {
                      calculateBmi();
                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          _isFinished = true;
                        });
                      });
                    },
                    activeColor: Assets.pColor,
                    buttonWidget: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    buttonText: "CALCULATE",
                  ),
                ),
                const SizedBox(height: 22.5),
                const Divider(color: Assets.pColor),
                const SocialMediaAccounts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    if (_weight != null && _weight! > 0 && _height != null && _height! > 0) {
      _bmiScore = _weight! / pow(_height! / 100, 2);
    } else {
      _bmiScore = 0;
    }
  }

  void _resetValues() {
    setState(() {
      _gender = null;
      _height = null;
      _age = null;
      _weight = null;
      _isAgeSelected = true;
      _isHeightSelected = true;
      _isWeightSelected = true;
      _isGenderSelected = true;
    });
  }
}
