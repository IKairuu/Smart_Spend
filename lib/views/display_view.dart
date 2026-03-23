import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class DisplayView extends StatefulWidget {
  const DisplayView({super.key});

  @override
  State<DisplayView> createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: container_colors,
      builder: (context, decorate, child) {
        return ValueListenableBuilder(
          valueListenable: dark_mode,
          builder: (context, dark, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: MainPageValues.displayBalancePadding,
                    left: MainPageValues.displayBalancePadding,
                    bottom: MainPageValues.displayBalancePadding,
                  ),
                  child: Container(
                    height: 120,
                    width: double.infinity,
                    decoration: decorate,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text("Today's", style: TextStyleDisplay.main_text),
                          Text(
                            "Balance: ${ExpensesTabs.total_balance >= 0 ? "+" : "-"}₱${ExpensesTabs.total_balance.abs()}",
                            style: ExpensesTabs.total_balance >= 0
                                ? TextStyleDisplay.main_text_positive
                                : TextStyleDisplay.main_text_negative,
                          ),
                          Divider(
                            thickness: 2,
                            color: dark ? Colors.white : Colors.black,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Expenses: -₱${ExpensesTabs.total_expenses}",
                                style: TextStyleDisplay.expenses_text,
                              ),
                              SizedBox(width: 40),
                              Text(
                                "Income: +₱${ExpensesTabs.total_income}",
                                style: TextStyleDisplay.income_text,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: expenses_data,
                  builder: (context, list, child) {
                    return SingleChildScrollView(
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: ValueListenableBuilder(
                          valueListenable: dark_mode,
                          builder: (context, dark, child) {
                            return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                    left: MainPageValues.displayBalancePadding,
                                    right: MainPageValues.displayBalancePadding,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: dark
                                          ? ColorContainer.main_containers_dark
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20),
                                        AppDatabase.identify_icon(
                                              list[index]["category"],
                                            )
                                            as Icon,
                                        VerticalDivider(
                                          indent: 5,
                                          endIndent: 5,
                                          color: dark
                                              ? Colors.white
                                              : Colors.black,
                                          thickness: 2,
                                        ),
                                        Expanded(
                                          child: Text(list[index]["name"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 10,
                                          ),
                                          child: Text(
                                            style: list[index]["expense"]
                                                ? TextStyleDisplay
                                                      .display_text_expense
                                                : TextStyleDisplay
                                                      .display_text_income,
                                            "${list[index]["expense"] ? "-" : "+"}${list[index]["cost"]}",
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
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
