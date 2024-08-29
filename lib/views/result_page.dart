import 'package:bmi/utils/assets.dart';
import 'package:bmi/widgets/action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/bmi_status.dart';
import '../widgets/diet_advice.dart';
import '../widgets/gauage_section.dart';

class ResultPage extends StatelessWidget {
  final double bmiScore;
  final int age;
  final String bmiStatus;
  final String bmiInterpretation;
  final Color bmiStatusColor;
  final String dietAdvice;
  final int gender;
  final Color backgroundColor;
  ResultPage({
    super.key,
    required this.bmiScore,
    required this.age,
    required this.gender,
  })  : bmiStatus = _calculateBmiStatus(bmiScore),
        bmiInterpretation = _calculateBmiInterpretation(bmiScore),
        bmiStatusColor = _calculateBmiStatusColor(bmiScore),
        dietAdvice = _getDietAdvice(bmiScore),
        backgroundColor = gender == 1 ? Assets.maleColor : Assets.femaleColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          "BMI Score",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: backgroundColor,
          child: Card(
            margin: const EdgeInsets.all(12),
            elevation: 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GaugeSection(
                    bmiScore: bmiScore, backgroundColor: backgroundColor),
                const SizedBox(height: 10),
                BmiStatusSection(
                    bmiStatus: bmiStatus, bmiStatusColor: bmiStatusColor),
                const SizedBox(height: 10),
                DietAdviceSection(
                    dietAdvice: dietAdvice, backgroundColor: backgroundColor),
                const SizedBox(height: 30),
                ActionButtons(
                  onRecalculate: () => Navigator.pop(context, true),
                  onShare: () async {
                    await FlutterShare.share(
                      title: 'BMI Score',
                      text:
                          "Your BMI Score is ${bmiScore.toStringAsFixed(1)} at Age $age. Status: $bmiStatus. Interpretation: $bmiInterpretation. Advice: $dietAdvice",
                    );
                  },
                  onFeedback: _sendEmail,
                  backgroundColor: backgroundColor,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _calculateBmiStatus(double bmiScore) {
    if (bmiScore > 30) {
      return "Obese";
    } else if (bmiScore >= 25) {
      return "Over Weight";
    } else if (bmiScore >= 18.5) {
      return "Normal";
    } else {
      return "Under Weight";
    }
  }

  static String _calculateBmiInterpretation(double bmiScore) {
    if (bmiScore > 30) {
      return "Please Work To Reduce Obesity";
    } else if (bmiScore >= 25) {
      return "Do Regular Exercise And Reduce The Weight";
    } else if (bmiScore >= 18.5) {
      return "Enjoy, You Are Fit";
    } else {
      return "Try To Increase The Weight";
    }
  }

  static Color _calculateBmiStatusColor(double bmiScore) {
    if (bmiScore > 30) {
      return Colors.pink;
    } else if (bmiScore >= 25) {
      return Colors.orange;
    } else if (bmiScore >= 18.5) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  static String _getDietAdvice(double bmiScore) {
    if (bmiScore > 30) {
      return "Consider a low-calorie, balanced diet with plenty of vegetables and lean proteins.";
    } else if (bmiScore >= 25) {
      return "Incorporate more fiber and lean proteins into your diet and reduce high-calorie foods.";
    } else if (bmiScore >= 18.5) {
      return "Maintain a balanced diet with a mix of protein, carbohydrates, and healthy fats.";
    } else {
      return "Focus on a nutrient-rich diet to help reach a healthy weight.";
    }
  }

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'peterelia914@gmail.com',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch $emailLaunchUri');
    }
  }
}
