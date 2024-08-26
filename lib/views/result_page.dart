import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatelessWidget {
  final double bmiScore;
  final int age;
  final String bmiStatus;
  final String bmiInterpretation;
  final Color bmiStatusColor;

  ResultPage({
    super.key,
    required this.bmiScore,
    required this.age,
  })  : bmiStatus = _calculateBmiStatus(bmiScore),
        bmiInterpretation = _calculateBmiInterpretation(bmiScore),
        bmiStatusColor = _calculateBmiStatusColor(bmiScore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "BMI Score",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Score",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ),
              SizedBox(height: 10),
              PrettyGauge(
                gaugeSize: 300,
                minValue: 0,
                maxValue: 40,
                segments: [
                  GaugeSegment('Under Weight', 18.5, Colors.red),
                  GaugeSegment('Normal', 6.4, Colors.green),
                  GaugeSegment('Over Weight', 5, Colors.orange),
                  GaugeSegment('Obese', 10.1, Colors.pink),
                ],
                valueWidget: Text(
                  bmiScore.toStringAsFixed(1),
                  style: TextStyle(fontSize: 50),
                ),
                currentValue: bmiScore.toDouble(),
                needleColor: Colors.blue,
              ),
              SizedBox(height: 10),
              Text(
                bmiStatus,
                style: TextStyle(fontSize: 20, color: bmiStatusColor),
              ),
              SizedBox(height: 10),
              Text(
                bmiInterpretation,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Re-Calculate"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await FlutterShare.share(
                        title: 'BMI Score',
                        text:
                            "Your BMI Score is ${bmiScore.toStringAsFixed(1)} at Age $age. Status: $bmiStatus. Interpretation: $bmiInterpretation",
                      );
                    },
                    child: Text("Share"),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _sendEmail,
                child: Text("Feedback"),
              ),
            ],
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
