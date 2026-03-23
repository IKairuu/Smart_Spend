import 'package:flutter/material.dart';
import 'package:smart_spend/pages/welcome_page.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WelcomePage());
  }
}
