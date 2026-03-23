import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/database_functions.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';
import 'package:intl/intl.dart';

class RemoveExpenses extends StatefulWidget {
  const RemoveExpenses({super.key});

  @override
  State<RemoveExpenses> createState() => _RemoveExpensesState();
}

class _RemoveExpensesState extends State<RemoveExpenses> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MainPageValues.displayBalancePadding),
      child: ValueListenableBuilder(
        valueListenable: dark_mode,
        builder: (context, dark, child) {
          return Column(
            children: [
              SizedBox(height: 60),
              ValueListenableBuilder(
                valueListenable: container_colors,
                builder: (context, decorate, child) {
                  return Container(
                    height: 250,
                    decoration: decorate,
                    child: ListView.builder(
                      itemCount: AppDatabase.get_data().length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          value: AppDatabase.get_data()[index]["selected"],
                          onChanged: (value) {
                            setState(() {
                              dynamic data = AppDatabase.get_data()[index];
                              User_Data edit = User_Data(
                                date: data["date"],
                                name: data["name"],
                                category: data["category"],
                                cost: data["cost"],
                                expenses: data["expense"],
                                selected: data["selected"],
                              );
                              final int data_index = AppDatabase.identify_key(
                                data["name"],
                              );
                              edit.selected = value;

                              AppDatabase.edit_data(edit, data_index);
                              if (value == true) {
                                remove_expenses_data.value.add(data["name"]);
                              } else {
                                remove_expenses_data.value.remove(data["name"]);
                              }
                              if (StatisticsPage.date_selected ==
                                  DateFormat.yMd()
                                      .format(DateTime.now())
                                      .toString()) {
                                AppDatabase.refresh_data();
                              }
                            });
                          },
                          title: Row(
                            children: [
                              AppDatabase.identify_icon(
                                    AppDatabase.get_data()[index]["category"],
                                  )
                                  as Icon,
                              VerticalDivider(
                                thickness: 2,
                                endIndent: 2,
                                indent: 2,
                                color: Colors.black,
                              ),
                              Text(AppDatabase.get_data()[index]["name"]),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      if (remove_expenses_data.value.isNotEmpty) {
                        AppDatabase.remove_items();
                        view.value = expenses_tab.DisplayExpenses;
                        AppDatabase.calculate_all_display();
                        if (StatisticsPage.date_selected ==
                            DateFormat.yMd()
                                .format(DateTime.now())
                                .toString()) {
                          AppDatabase.refresh_data();
                        }
                        AppDatabase.calculate_overall();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("No items selected"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    });
                  },
                  icon: const Icon(FontAwesomeIcons.trash),
                  label: const Text("Remove"),
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
                    fixedSize: const Size(310, 40),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
