import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
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
                  SizedBox(height: 10),
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
                ],
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.facebook, color: Colors.blue),
                  onPressed: () => _launchURL(
                      'https://www.facebook.com/profile.php?id=100008335519291'),
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL(
                      'https://www.linkedin.com/in/peter-elia-648485240/'),
                ),
              ],
            ),
          ],
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

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
