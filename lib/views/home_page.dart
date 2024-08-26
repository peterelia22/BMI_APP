import 'dart:core';
import 'dart:math';

import 'package:bmi/views/result_page.dart';
import 'package:bmi/widgets/age_and_weight.dart';
import 'package:bmi/widgets/height.dart';
import 'package:bmi/widgets/social_media_accounts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:url_launcher/url_launcher.dart';

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

  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          //  color: Colors.black,
          elevation: 10,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Gender(
                onChanged: (genderVal) {
                  _gender = genderVal;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Height(
                onChanged: (heightVal) {
                  _height = heightVal;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    title: "  Weight  (Kg)  ",
                    onChange: (weightVal) {
                      _weight = weightVal;
                    },
                    min: 0,
                    max: 300,
                    initValue: 50,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: SwipeableButtonView(
                  isFinished: _isFinished,
                  onFinish: () async {
                    await Navigator.push(
                      context,
                      PageTransition(
                        child: ResultPage(bmiScore: _bmiScore, age: _age),
                        type: PageTransitionType.fade,
                      ),
                    );
                    setState(() {
                      _isFinished = false;
                    });
                  },
                  onWaitingProcess: () {
                    calculateBmi();
                    Future.delayed(Duration(seconds: 1), () {
                      setState(() {
                        _isFinished = true;
                      });
                    });
                  },
                  activeColor: Colors.blue,
                  buttonWidget: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                  buttonText: "CALCULATE",
                ),
              ),
              SizedBox(height: 50),

              Divider(
                color: Colors.blue,
              ),
              SocialMediaAccounts(),
              //      SizedBox(height: 10),
            ]),
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }
}
