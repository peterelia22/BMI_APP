import 'package:flutter/material.dart';

class Height extends StatefulWidget {
  const Height({super.key});

  @override
  State<Height> createState() => _HeightState();
}

class _HeightState extends State<Height> {
  int _height = 100;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(),
      child: Column(
        children: [
          const Text(
            'Height',
            style: TextStyle(color: Colors.grey, fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _height.toString(),
                style: TextStyle(fontSize: 40),
              ),
              Text(
                'cm',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ),
          Slider(
              min: 0,
              max: 230,
              value: _height.toDouble(),
              onChanged: (value) {
                setState(() {
                  _height = value.toInt();
                });
              })
        ],
      ),
    );
  }
}
