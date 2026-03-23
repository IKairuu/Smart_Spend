import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeBackground extends StatelessWidget {
  const WelcomeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: LottieBuilder.asset(
        "assets/images/welcome_background.json",
        fit: BoxFit.cover,
      ),
    );
  }
}
