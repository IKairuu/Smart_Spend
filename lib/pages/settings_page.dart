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
import 'package:smart_spend/widgets/edit_profile.dart';

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
            backgroundColor: Color.fromRGBO(23, 27, 30, 1),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                });
              },
            ),
            title: Text("Settings", style: SettingDesign.setting_labels),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: ColorContainer.setting_section_background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  child: Text(
                    "PREFERENCES",
                    style: SettingDesign.setting_labels,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(Icons.dark_mode_sharp, color: Colors.white),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SwitchListTile.adaptive(
                            title: Text(
                              "Dark Mode",
                              style: SettingDesign.setting_labels,
                            ),
                            subtitle: Text(
                              "Switch App appearance",
                              style: SettingDesign.setting_labels,
                            ),
                            value: dark,
                            onChanged: (value) async {
                              final SharedPreferences preference =
                                  await SharedPreferences.getInstance();
                              await preference.setBool(
                                Settings.dark_mode,
                                value,
                              );
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
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  child: Text(
                    "DANGER ZONES",
                    style: SettingDesign.setting_labels,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.trashCan, color: Colors.white),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            "Delete Data",
                            style: TextStyleDisplay.clear_data_font,
                          ),
                          subtitle: Text(
                            "Clear All Data",
                            style: SettingDesign.setting_labels,
                          ),
                          trailing: ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        SettingDesign.alert_background_color,
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
                                            expenses_data.value =
                                                AppDatabase.get_data();
                                            memos.value =
                                                AppDatabase.get_memo_data();
                                            dark_mode.value = false;
                                            container_colors.value =
                                                BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                );
                                            SettingDesign.text_fields =
                                                InputDecoration(
                                                  fillColor: ColorContainer
                                                      .setting_light_color,
                                                  filled: true,
                                                  border: OutlineInputBorder(),
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
                                              builder: (context) =>
                                                  WidgetTree(),
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
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.red,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  child: Text("PROFILE", style: SettingDesign.setting_labels),
                ),
                EditProfile(),
              ],
            ),
          ),
        );
      },
    );
  }
}
