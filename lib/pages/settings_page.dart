import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/pages/main_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
              );
            });
          },
        ),
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: dark_mode,
            builder: (context, mode, child) {
              return SwitchListTile.adaptive(
                title: Text("Dark Mode", style: TextStyleDisplay.settings_font),
                value: mode,
                onChanged: (value) async {
                  final SharedPreferences preference =
                      await SharedPreferences.getInstance();
                  await preference.setBool(Settings.dark_mode, value);
                  setState(() {
                    dark_mode.value = value;
                    if (value) {
                      container_colors.value = BoxDecoration(
                        color: ColorContainer.main_containers_dark,
                        borderRadius: BorderRadius.circular(20),
                      );
                    } else {
                      container_colors.value = BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      );
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
