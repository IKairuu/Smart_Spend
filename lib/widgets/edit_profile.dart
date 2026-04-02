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
              color: SettingDesign.profile_background,

              border: BoxBorder.all(color: SettingDesign.profile_border),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_pin_rounded,
                          color: SettingDesign.icon_color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "EDIT PROFILE",
                          style: SettingDesign.setting_labels,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text("Name", style: SettingDesign.setting_labels),
                      SizedBox(width: 155),
                      Text("Nickname", style: SettingDesign.setting_labels),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(
                          controller: name_controller,
                          decoration: SettingDesign.text_fields,
                          style: SettingDesign.textfield_input_style,
                        ),
                      ),
                      SizedBox(width: 37),
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(
                          controller: nick_name_controller,
                          decoration: SettingDesign.text_fields,
                          style: SettingDesign.textfield_input_style,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Row(
                        children: [
                          Text("Gender", style: SettingDesign.setting_labels),
                          SizedBox(width: 145),
                          Text("Age", style: SettingDesign.setting_labels),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 155,
                            height: 40,
                            child: DropdownMenu(
                              textStyle: SettingDesign.dropdown_textstyle,
                              controller: gender_controller,
                              inputDecorationTheme:
                                  SettingDesign.dropdown_decoration,
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
                              style: SettingDesign.textfield_input_style,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text("Occupation", style: SettingDesign.setting_labels),

                      SizedBox(width: 105),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "Balance",
                          style: SettingDesign.setting_labels,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 155,
                        height: 40,
                        child: DropdownMenu(
                          textStyle: SettingDesign.dropdown_textstyle,
                          controller: occupation_controller,
                          inputDecorationTheme:
                              SettingDesign.dropdown_decoration,
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
                      Container(
                        width: 155,
                        height: 40,
                        child: TextField(
                          controller: balance_controller,
                          decoration: SettingDesign.text_fields,
                          style: SettingDesign.textfield_input_style,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SettingDesign.confirm_button,
                        foregroundColor: SettingDesign.button_foreground_color,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
