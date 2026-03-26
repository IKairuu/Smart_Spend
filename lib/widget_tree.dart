import 'package:flutter/material.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/pages/main_page.dart';
import 'package:smart_spend/pages/welcome_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: user_signed_in,
      builder: (context, value, child) {
        return Scaffold(body: value ? MainPage() : WelcomePage());
      },
    );
  }
}
