import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_spend/constants/notifier.dart';

class MainBackgroundDay extends StatefulWidget {
  const MainBackgroundDay({super.key});

  @override
  State<MainBackgroundDay> createState() => _MainBackgroundDayState();
}

class _MainBackgroundDayState extends State<MainBackgroundDay> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, mode, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          child: LottieBuilder.asset(
            mode
                ? "assets/images/main_night.json"
                : "assets/images/main_day.json",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
