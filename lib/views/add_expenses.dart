import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/database_functions.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({super.key});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  TextEditingController name_controller = TextEditingController();
  TextEditingController cost_controller = TextEditingController();
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
                height: 300,
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
                              "Item Name: ",
                              style: TextStyleDisplay.field_text,
                            ),
                            Container(
                              width: ExpensesTabs.field_width,
                              height: ExpensesTabs.field_height,
                              child: TextField(
                                controller: name_controller,
                                decoration: dark
                                    ? ExpensesTabs.field_decoration_dark
                                    : ExpensesTabs.field_decoration_light,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                          left: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Category: ",
                              style: TextStyleDisplay.field_text,
                            ),
                            SizedBox(width: 15),
                            Container(
                              width: ExpensesTabs.field_width,
                              height: ExpensesTabs.field_height,
                              child: MultiDropdown(
                                singleSelect: true,
                                onSelectionChange: (selectedItems) {
                                  ExpensesTabs.category = selectedItems[0];
                                },
                                fieldDecoration: FieldDecoration(
                                  prefixIcon: Icon(Icons.filter_list),
                                  borderRadius: 20,
                                ),
                                dropdownItemDecoration: DropdownItemDecoration(
                                  backgroundColor: dark
                                      ? ColorContainer.main_containers_indicator
                                      : ColorContainer.main_containers_light,
                                  selectedBackgroundColor: dark
                                      ? ColorContainer.main_containers_light
                                      : ColorContainer
                                            .main_containers_indicator,
                                  selectedTextColor: Colors.white,
                                  selectedIcon: Icon(
                                    FontAwesomeIcons.checkCircle,
                                  ),
                                ),
                                items: [
                                  DropdownItem(label: "Food", value: "Food"),
                                  DropdownItem(
                                    label: "Transport",
                                    value: "Transport",
                                  ),
                                  DropdownItem(
                                    label: "Groceries",
                                    value: "Groceries",
                                  ),
                                  DropdownItem(
                                    label: "Entertainment",
                                    value: "Entertainment",
                                  ),
                                  DropdownItem(
                                    label: "Education",
                                    value: "Education",
                                  ),
                                  DropdownItem(label: "Bills", value: "Bills"),
                                  DropdownItem(
                                    label: "Health",
                                    value: "Health",
                                  ),
                                  DropdownItem(
                                    label: "Others",
                                    value: "Others",
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                            Text("Cost: ", style: TextStyleDisplay.field_text),
                            SizedBox(width: 45),
                            Container(
                              width: ExpensesTabs.field_width,
                              height: ExpensesTabs.field_height,
                              child: TextField(
                                controller: cost_controller,
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
                              if (ExpensesTabs.category == "default" ||
                                  name_controller.text.trim().isEmpty ||
                                  cost_controller.text.trim().isEmpty ||
                                  name_controller.text.isEmpty ||
                                  cost_controller.text.isEmpty ||
                                  double.tryParse(cost_controller.text) ==
                                      null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Invalid Input"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else if (AppDatabase.identify_duplicates(
                                name_controller.text,
                              )) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Name already exists."),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                AppDatabase.add_data(
                                  User_Data(
                                    date: DateFormat.yMd()
                                        .format(DateTime.now())
                                        .toString(),
                                    name: name_controller.text,
                                    category: ExpensesTabs.category,
                                    cost: double.parse(cost_controller.text),
                                    expenses: true,
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
