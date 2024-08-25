import 'package:flutter/material.dart';

import 'package:flutter_share/flutter_share.dart';
import 'package:pretty_gauge/pretty_gauge.dart';

class ResultPage extends StatelessWidget {
  final double bmiScore;
  final int age;
  String? bmiStatus;
  String? bmiInterpretation;
  Color? bmiStatusColor;

  ResultPage({super.key, required this.bmiScore, required this.age});

  @override
  Widget build(BuildContext context) {
    setBmiInterpretation();
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
              SizedBox(
                height: 10,
              ),
              PrettyGauge(
                gaugeSize: 300,
                minValue: 0,
                maxValue: 40,
                segments: [
                  GaugeSegment('Under Weight', 18.5, Colors.red),
                  GaugeSegment('Normal', 6.4, Colors.green),
                  GaugeSegment('Over Weight', 5, Colors.orange),
                  GaugeSegment('Obese', 10.1, Colors.pink)
                ],
                valueWidget: Text(
                  bmiScore.toStringAsFixed(1),
                  style: TextStyle(fontSize: 50),
                ),
                currentValue: bmiScore.toDouble(),
                needleColor: Colors.blue,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                bmiStatus!,
                style: TextStyle(fontSize: 20, color: bmiStatusColor!),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                bmiInterpretation!,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Re-Calculate"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
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
      ),
    );
  }

  void setBmiInterpretation() {
    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please Work To Reduce Obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Over Weight";
      bmiInterpretation = "Do Regular Exercise And Reduce The Weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You Are Fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Under Weight";
      bmiInterpretation = "Try To Increase The Weight";
      bmiStatusColor = Colors.red;
    }
  }
}
