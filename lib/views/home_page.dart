import 'dart:core';
import 'dart:math';

import 'package:bmi/views/result_page.dart';
import 'package:bmi/widgets/age_and_weight.dart';
import 'package:bmi/widgets/height.dart';
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
      body: SizedBox.expand(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: SwipeableButtonView(
                          isFinished: _isFinished,
                          onFinish: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                child:
                                    ResultPage(bmiScore: _bmiScore, age: _age),
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
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.facebookF,
                                color: Colors.blue),
                            onPressed: () => _launchURL(
                                'https://www.facebook.com/profile.php?id=100008335519291'), // Replace with your Facebook profile URL
                          ),
                          const SizedBox(width: 20), // Space between the icons
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.github,
                                color: Colors.black),
                            onPressed: () => _launchURL(
                                'https://github.com/peterelia22'), // Replace with your GitHub profile URL
                          ),
                          const SizedBox(width: 20), // Space between the icons
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.linkedinIn,
                                color: Colors.blue),
                            onPressed: () => _launchURL(
                                'https://www.linkedin.com/in/peter-elia-648485240/'), // Replace with your LinkedIn profile URL
                          ),

                        ]
                      ),SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBmi() {
    _bmiScore = _weight / pow(_height / 100, 2);
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
