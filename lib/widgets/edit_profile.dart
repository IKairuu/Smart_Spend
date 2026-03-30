import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';
import 'package:smart_spend/functions/manage_user.dart';
import 'package:smart_spend/pages/main_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name_controller = TextEditingController(
    text: UserManagement.get_user_name(user_data.value!),
  );
  TextEditingController nick_name_controller = TextEditingController(
    text: user_data
        .value![UserManagement.get_user_name(user_data.value!)]["nickname"],
  );
  TextEditingController gender_controller = TextEditingController(
    text: user_data
        .value![UserManagement.get_user_name(user_data.value!)]["gender"],
  );
  TextEditingController age_controller = TextEditingController(
    text: user_data
        .value![UserManagement.get_user_name(user_data.value!)]["age"]
        .toString(),
  );
  TextEditingController occupation_controller = TextEditingController(
    text: user_data
        .value![UserManagement.get_user_name(user_data.value!)]["occupation"],
  );
  TextEditingController balance_controller = TextEditingController(
    text: user_data
        .value![UserManagement.get_user_name(user_data.value!)]["balance"]
        .toString(),
  );
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
                        child: TextField(
                          controller: name_controller,
                          decoration: SettingDesign.text_fields,
                        ),
                      ),
                      SizedBox(width: 37),
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(
                          controller: nick_name_controller,
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
                              controller: gender_controller,
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
                              controller: age_controller,
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
                          controller: occupation_controller,
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
                        child: TextField(
                          controller: balance_controller,
                          decoration: SettingDesign.text_fields,
                        ),
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
                      onPressed: () {
                        if (name_controller.text.trim().isEmpty ||
                            nick_name_controller.text.trim().isEmpty ||
                            gender_controller.text.trim().isEmpty ||
                            age_controller.text.trim().isEmpty ||
                            occupation_controller.text.trim().isEmpty ||
                            balance_controller.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Invalid Input"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else if (name_controller.text ==
                                UserManagement.get_user_name(
                                  user_data.value!,
                                ) &&
                            nick_name_controller.text ==
                                user_data.value![UserManagement.get_user_name(
                                  user_data.value!,
                                )]["nickname"] &&
                            gender_controller.text ==
                                user_data.value![UserManagement.get_user_name(
                                  user_data.value!,
                                )]["gender"] &&
                            age_controller.text ==
                                user_data
                                    .value![UserManagement.get_user_name(
                                      user_data.value!,
                                    )]["age"]
                                    .toString() &&
                            occupation_controller.text ==
                                user_data.value![UserManagement.get_user_name(
                                  user_data.value!,
                                )]["occupation"] &&
                            balance_controller.text ==
                                user_data
                                    .value![UserManagement.get_user_name(
                                      user_data.value!,
                                    )]["balance"]
                                    .toString()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("No credentials changed"),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Change User Credentials"),
                              content: Text(
                                "Are you sure you want to change your credentials?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      Map<String, dynamic> data = {
                                        name_controller.text: {
                                          "nickname": nick_name_controller.text,
                                          "gender": gender_controller.text,
                                          "age": int.parse(age_controller.text),
                                          "occupation":
                                              occupation_controller.text,
                                          "balance": double.parse(
                                            balance_controller.text,
                                          ),
                                        },
                                      };
                                      await UserManagement.save_user_data(data);
                                      user_data.value =
                                          await UserManagement.load_user_data();
                                      overall_balance.value =
                                          user_data
                                              .value![UserManagement.get_user_name(
                                            user_data.value!,
                                          )]["balance"];
                                      AppDatabase.calculate_overall();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainPage(),
                                        ),
                                      );
                                    } catch (error) {
                                      print(error);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "Invalid age or balance input",
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        }
                      },
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
