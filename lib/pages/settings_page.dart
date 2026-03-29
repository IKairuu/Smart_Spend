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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                child: Text("PREFERENCES"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.dark_mode_sharp),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: SwitchListTile.adaptive(
                          title: Text(
                            "Dark Mode",
                            style: TextStyleDisplay.settings_font,
                          ),
                          subtitle: Text("Switch App appearance"),
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
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, top: 10),
                child: Text("DANGER ZONES"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.trashCan),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          "Delete Data",
                          style: TextStyleDisplay.clear_data_font,
                        ),
                        subtitle: Text("Clear All Data"),
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
                child: Text("PROFILE"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Container(
                  width: 500,
                  height: 300,
                  decoration: BoxDecoration(
                    color: dark
                        ? ColorContainer.setting_section_background
                        : ColorContainer.stats_main_color,
                    border: BoxBorder.all(
                      color: dark
                          ? ColorContainer.setting_light_color
                          : ColorContainer.setting_section_background,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Icon(Icons.person_pin_rounded),
                            SizedBox(width: 5),
                            Text("EDIT PROFILE"),
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Text(
                              "Name",
                              style: TextStyleDisplay.settings_profile_labels,
                            ),
                            SizedBox(width: 150),
                            Text(
                              "Nickname",
                              style: TextStyleDisplay.settings_profile_labels,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 30,
                              child: TextField(
                                decoration: SettingDesign.text_fields,
                              ),
                            ),
                            SizedBox(width: 37),
                            Container(
                              width: 150,
                              height: 30,
                              child: TextField(
                                decoration: SettingDesign.text_fields,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Text(
                                  "Gender",
                                  style:
                                      TextStyleDisplay.settings_profile_labels,
                                ),
                                SizedBox(width: 150),
                                Text(
                                  "Age",
                                  style:
                                      TextStyleDisplay.settings_profile_labels,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  height: 30,
                                  child: TextField(
                                    decoration: SettingDesign.text_fields,
                                  ),
                                ),
                                SizedBox(width: 37),
                                Container(
                                  width: 150,
                                  height: 30,
                                  child: TextField(
                                    decoration: SettingDesign.text_fields,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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
