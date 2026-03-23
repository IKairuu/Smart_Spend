import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({super.key});

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: view,
      builder: (context, views, child) {
        return ValueListenableBuilder(
          valueListenable: dark_mode,
          builder: (context, dark, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(ExpensesTabs.tab_paddings),
                  child: SegmentedButtonTheme(
                    data: SegmentedButtonThemeData(
                      style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(10),
                        overlayColor: WidgetStatePropertyAll(
                          dark
                              ? ColorContainer.main_containers_indicator
                              : ColorContainer.main_containers_light,
                        ),
                      ),
                    ),
                    child: SegmentedButton(
                      style: SegmentedButton.styleFrom(
                        backgroundColor: dark
                            ? ColorContainer.main_containers_dark
                            : Colors.white,
                        foregroundColor: dark ? Colors.white : Colors.black,
                        selectedBackgroundColor: dark
                            ? ColorContainer.main_containers_indicator
                            : ColorContainer.main_containers_light,
                      ),
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: expenses_tab.DisplayExpenses,
                          label: Text(
                            "Expenses",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        ButtonSegment(
                          value: expenses_tab.AddExpenses,
                          label: Text(
                            "Add Expenses",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        ButtonSegment(
                          value: expenses_tab.AddIncome,
                          label: Text(
                            "Add Income",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        ButtonSegment(
                          value: expenses_tab.RemoveExpenses,
                          label: Text(
                            "Remove Items",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                      selected: <expenses_tab>{view.value},
                      onSelectionChanged: (selection) {
                        setState(() {
                          view.value = selection.first;
                        });
                      },
                    ),
                  ),
                ),
                Center(child: ExpensesTabs.tabs[views]),
              ],
            );
          },
        );
      },
    );
  }
}
