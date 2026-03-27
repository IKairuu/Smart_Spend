import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 280,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                child: LottieBuilder.asset(
                  "assets/images/welcome_text.json",
                  height: 200,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    current_welcome_widget.value = 1;
                    expenses_data.value = AppDatabase.get_data();
                    memos.value = AppDatabase.get_memo_data();
                    memo_check_data.value =
                        AppDatabase.generate_check_box_memo();
                    AppDatabase.calculate_all_display();
                    AppDatabase.calculate_overall();
                    AppDatabase.refresh_data();
                  });
                },
                child: Text("OPEN"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Color.fromRGBO(103, 80, 164, 1),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
