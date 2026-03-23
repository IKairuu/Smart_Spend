import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/database_functions.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  TextEditingController income_name = TextEditingController();
  TextEditingController income_cost = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MainPageValues.displayBalancePadding),
      child: ValueListenableBuilder(
        valueListenable: dark_mode,
        builder: (context, dark, child) {
          return ValueListenableBuilder(
            valueListenable: container_colors,
            builder: (context, decorate, child) {
              return Container(
                width: double.infinity,
                height: 270,
                decoration: decorate,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Input the following fields",
                        style: TextStyleDisplay.main_text,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Divider(
                          thickness: 2,
                          color: dark ? Colors.white : Colors.black,
                          indent: 15,
                          endIndent: 15,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Income Name: ",
                              style: TextStyleDisplay.field_text,
                            ),
                            Container(
                              width: ExpensesTabs.field_width,
                              height: ExpensesTabs.field_height,
                              child: TextField(
                                controller: income_name,
                                decoration: dark
                                    ? ExpensesTabs.field_decoration_dark
                                    : ExpensesTabs.field_decoration_light,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Income: ",
                              style: TextStyleDisplay.field_text,
                            ),
                            SizedBox(width: 45),
                            Container(
                              width: ExpensesTabs.field_width,
                              height: ExpensesTabs.field_height,
                              child: TextField(
                                controller: income_cost,
                                decoration: dark
                                    ? ExpensesTabs.field_decoration_dark
                                    : ExpensesTabs.field_decoration_light,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (income_name.text.trim().isEmpty ||
                                  income_cost.text.trim().isEmpty ||
                                  income_name.text.isEmpty ||
                                  income_cost.text.isEmpty ||
                                  double.tryParse(income_cost.text) == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Invalid Input"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                AppDatabase.add_data(
                                  User_Data(
                                    date: DateFormat.yMd()
                                        .format(DateTime.now())
                                        .toString(),
                                    name: income_name.text,
                                    category: "income",
                                    cost: double.parse(income_cost.text),
                                    expenses: false,
                                    selected: false,
                                  ),
                                );
                                expenses_data.value = AppDatabase.get_data();
                                AppDatabase.calculate_all_display();
                                if (StatisticsPage.date_selected ==
                                    DateFormat.yMd()
                                        .format(DateTime.now())
                                        .toString()) {
                                  AppDatabase.refresh_data();
                                }
                                AppDatabase.calculate_overall();
                                view.value = expenses_tab.DisplayExpenses;
                              }
                            });
                          },
                          icon: const Icon(Icons.add_circle),
                          label: const Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: dark
                                ? ColorContainer.main_containers_indicator
                                : ColorContainer.stats_main_color,
                            foregroundColor: dark
                                ? ColorContainer.stats_main_color
                                : ColorContainer.main_containers_indicator,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                            fixedSize: const Size(250, 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
