import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/widgets/welcome_background.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: current_welcome_widget,
        builder: (context, value, child) {
          return Stack(
            children: [
              WelcomeBackground(),
              WelcomePageValues.welcome_pages[value],
            ],
          );
        },
      ),
    );
  }
}
