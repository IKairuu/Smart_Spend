import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:list_selection_widget/list_selection_widget.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/manage_user.dart';
import 'package:smart_spend/pages/main_page.dart';

class CredentialsWidget extends StatefulWidget {
  const CredentialsWidget({super.key});

  @override
  State<CredentialsWidget> createState() => _CredentialsWidgetState();
}

class _CredentialsWidgetState extends State<CredentialsWidget> {
  TextEditingController user_name = TextEditingController();
  TextEditingController user_nick_name = TextEditingController();
  TextEditingController user_age = TextEditingController();
  TextEditingController user_balance = TextEditingController();
  TextEditingController user_gender = TextEditingController();
  TextEditingController user_occupation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double font_size = 15, box_size = 70;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: 570,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "SmartSpend",
                      style: GoogleFonts.audiowide(fontSize: 35),
                    ),
                  ),
                  Text(
                    "Enter the following fields",
                    style: TextStyle(
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: box_size,
                    child: TextFormField(
                      maxLength: 20,
                      style: TextStyle(fontSize: font_size),
                      controller: user_name,
                      decoration: InputDecoration(
                        filled: true,
                        icon: Icon(Icons.person_2_outlined),
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Color(0xFF6200EE)),
                        hintText: "Input Name",
                        helperText: 'Input your name',
                        suffixIcon: Icon(CupertinoIcons.clear_circled_solid),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: box_size,
                    child: TextFormField(
                      maxLength: 20,
                      style: TextStyle(fontSize: font_size),
                      controller: user_nick_name,
                      decoration: InputDecoration(
                        filled: true,
                        icon: Icon(Icons.abc_outlined),
                        labelText: 'Nickname',
                        labelStyle: TextStyle(color: Color(0xFF6200EE)),
                        hintText: "Input Name",
                        helperText: 'Input your desired nickname',
                        suffixIcon: Icon(CupertinoIcons.clear_circled_solid),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF6200EE)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text("Age: "),
                        SizedBox(
                          width: 60,
                          height: 50,
                          child: TextField(
                            controller: user_age,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Age",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text("Gender: "),
                        ),
                        SizedBox(
                          width: 120,
                          height: 50,
                          child: DropdownMenu(
                            controller: user_gender,
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hintText: "Gender",
                            dropdownMenuEntries: [
                              for (
                                int index = 0;
                                index < WelcomePageValues.genders.length;
                                index++
                              )
                                DropdownMenuEntry(
                                  label: WelcomePageValues.genders[index],
                                  value: WelcomePageValues.gender_code[index],
                                  leadingIcon:
                                      WelcomePageValues.gender_icon[index],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Text("Occupation: "),
                        SizedBox(
                          width: 190,
                          child: DropdownMenu(
                            controller: user_occupation,
                            leadingIcon: Icon(Icons.work_outline),
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            hintText: "Occupation",
                            dropdownMenuEntries: [
                              for (
                                int index = 0;
                                index < WelcomePageValues.occupations.length;
                                index++
                              )
                                DropdownMenuEntry(
                                  label: WelcomePageValues.occupations[index],
                                  value:
                                      WelcomePageValues.occupations_code[index],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Text("Balance: "),
                        SizedBox(width: 22),
                        SizedBox(
                          width: 190,
                          child: TextField(
                            controller: user_balance,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Balance",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (user_name.text.trim().isEmpty ||
                              user_nick_name.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Invalid name or nickname input"),
                              ),
                            );
                          } else if (user_age.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("There is no inputted age"),
                              ),
                            );
                          } else if (user_gender.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Gender input is required"),
                              ),
                            );
                          } else if (user_occupation.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Occupation input is required"),
                              ),
                            );
                          } else if (user_balance.text.trim().isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Balance input is required"),
                              ),
                            );
                          } else {
                            Map<String, dynamic> data = {
                              user_name.text: {
                                "nickname": user_nick_name.text,
                                "age": int.parse(user_age.text),
                                "gender": user_gender.text,
                                "occupation": user_occupation.text,
                                "balance": double.parse(user_balance.text),
                              },
                            };
                            await UserManagement.save_user_data(data);
                            user_data.value =
                                await UserManagement.load_user_data();
                            user_signed_in.value = false;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return MainPage();
                                },
                              ),
                            );
                          }
                        } catch (error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Age or Balance input is invalid"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(20),
                        ),
                        minimumSize: Size(double.infinity, 40),
                        backgroundColor: Color.fromRGBO(103, 80, 164, 1),
                        foregroundColor: Colors.white,
                      ),
                      child: Text("Confirm"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        current_widget.value = 0;
                      });
                    },
                    child: Text("Back"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(20),
                      ),
                      minimumSize: Size(double.infinity, 40),
                      backgroundColor: Color.fromRGBO(103, 80, 164, 1),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
