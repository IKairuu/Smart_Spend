import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Container(
            width: 500,
            height: 360,
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(width: 155),
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
                        width: 155,
                        height: 40,
                        child: TextField(decoration: SettingDesign.text_fields),
                      ),
                      SizedBox(width: 37),
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(decoration: SettingDesign.text_fields),
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
                            style: TextStyleDisplay.settings_profile_labels,
                          ),
                          SizedBox(width: 145),
                          Text(
                            "Age",
                            style: TextStyleDisplay.settings_profile_labels,
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
                            width: 155,
                            height: 40,
                            child: DropdownMenu(
                              inputDecorationTheme: InputDecorationTheme(
                                filled: true,
                                fillColor: dark
                                    ? Color.fromRGBO(46, 46, 46, 1)
                                    : ColorContainer.setting_light_color,
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                constraints: BoxConstraints.tight(
                                  Size.fromHeight(40),
                                ),
                              ),
                              trailingIcon: Icon(
                                Icons.arrow_drop_down_circle,
                                size: 20,
                              ),

                              dropdownMenuEntries: [
                                for (
                                  int index = 0;
                                  index < WelcomePageValues.genders.length;
                                  index++
                                )
                                  DropdownMenuEntry(
                                    value: WelcomePageValues.gender_code[index],
                                    label: WelcomePageValues.genders[index],
                                    leadingIcon:
                                        WelcomePageValues.gender_icon[index],
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 37),
                          Container(
                            width: 155,
                            height: 40,
                            child: TextField(
                              decoration: SettingDesign.text_fields,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Occupation",
                        style: TextStyleDisplay.settings_profile_labels,
                      ),
                    ),
                    SizedBox(width: 105),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Balance",
                        style: TextStyleDisplay.settings_profile_labels,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 155,
                        height: 40,
                        child: DropdownMenu(
                          inputDecorationTheme: InputDecorationTheme(
                            filled: true,
                            fillColor: dark
                                ? Color.fromRGBO(46, 46, 46, 1)
                                : ColorContainer.setting_light_color,
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            constraints: BoxConstraints.tight(
                              Size.fromHeight(40),
                            ),
                          ),
                          trailingIcon: Icon(
                            Icons.arrow_drop_down_circle,
                            size: 20,
                          ),

                          dropdownMenuEntries: [
                            for (
                              int index = 0;
                              index < WelcomePageValues.genders.length;
                              index++
                            )
                              DropdownMenuEntry(
                                value:
                                    WelcomePageValues.occupations_code[index],
                                label: WelcomePageValues.occupations[index],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 37),
                      Text(""),
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(decoration: SettingDesign.text_fields),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: dark
                            ? ColorContainer.main_containers_indicator
                            : ColorContainer.main_containers_light,
                        foregroundColor: dark ? Colors.white : Colors.black,
                      ),
                      onPressed: () {},
                      child: Text("Confirm"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
