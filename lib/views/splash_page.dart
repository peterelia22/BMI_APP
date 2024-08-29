import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:bmi/views/home_page.dart';
import 'package:bmi/utils/assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashTransition: SplashTransition.rotationTransition,
      duration: 40,
      splashIconSize: 200,
      backgroundColor: Assets.pColor,
      splash: const CircleAvatar(
        radius: 100,
        backgroundImage: AssetImage(Assets.assetsImagesBmi),
      ),
      nextScreen: const HomePage(),
    );
  }
}
