import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';
import 'package:smart_spend/functions/manage_user.dart';
import 'package:smart_spend/pages/main_page.dart';
import 'package:smart_spend/widget_tree.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
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
              SwitchListTile.adaptive(
                title: Text("Dark Mode", style: TextStyleDisplay.settings_font),
                value: dark,
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
              ),
              ListTile(
                leading: Text(
                  "Delete Data",
                  style: TextStyleDisplay.clear_data_font,
                ),
                trailing: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Clear All Data"),
                          content: Text(
                            "Clear Data? All data will be deleted permanently.",
                          ),
                          actionsAlignment: MainAxisAlignment.end,
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await AppDatabase.clear_expenses_data();
                                await AppDatabase.clear_memo_data();
                                await UserManagement.clear_user_data();
                                setState(() {
                                  expenses_data.value = AppDatabase.get_data();
                                  memos.value = AppDatabase.get_memo_data();
                                  dark_mode.value = false;
                                  container_colors.value = BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  );
                                  current_main_widget.value = 0;
                                  current_welcome_widget.value = 0;
                                  AppDatabase.refresh_data();
                                  AppDatabase.refresh_notifiers();
                                  AppDatabase.calculate_all_display();
                                  AppDatabase.calculate_overall();
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WidgetTree(),
                                  ),
                                );
                              },
                              child: Text(
                                "Yes",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                        barrierDismissible: true,
                      );
                    });
                  },
                  label: Icon(FontAwesomeIcons.trash),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.red),
                    foregroundColor: WidgetStatePropertyAll(Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
