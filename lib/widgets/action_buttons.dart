import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onRecalculate;
  final VoidCallback onShare;
  final VoidCallback onFeedback;
  final Color backgroundColor;

  const ActionButtons({
    super.key,
    required this.onRecalculate,
    required this.onShare,
    required this.onFeedback,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            child: ElevatedButton(
              onPressed: onRecalculate,
              child: Text("Re-Calculate",
                  style: TextStyle(color: backgroundColor)),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: onShare,
            child: Text("Share", style: TextStyle(color: backgroundColor)),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: FittedBox(
            child: ElevatedButton(
              onPressed: onFeedback,
              child: Text("Feedback", style: TextStyle(color: backgroundColor)),
            ),
          ),
        ),
      ],
    );
  }
}
