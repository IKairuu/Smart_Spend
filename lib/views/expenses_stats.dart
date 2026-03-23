import 'package:flutter/material.dart';
import 'package:smart_spend/Objects/overall_stats_object.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';
import 'package:smart_spend/Objects/expense_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tab_container/tab_container.dart';

class OverallStats extends StatefulWidget {
  const OverallStats({super.key});

  @override
  State<OverallStats> createState() => _OverallStatsState();
}

class _OverallStatsState extends State<OverallStats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: ValueListenableBuilder(
            valueListenable: dark_mode,
            builder: (context, dark, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: dark
                      ? ColorContainer.main_containers_indicator
                      : Colors.white,
                ),
                child: TabContainer(
                  tabs: [Text("Expense Graph"), Text("Overall Graph")],
                  borderRadius: BorderRadius.circular(20),
                  tabBorderRadius: BorderRadius.circular(20),
                  tabMaxLength: double.infinity,
                  colors: [
                    dark
                        ? ColorContainer.main_containers_dark
                        : ColorContainer.stats_tab_container,
                    dark
                        ? ColorContainer.main_containers_dark
                        : ColorContainer.stats_tab_container,
                  ],
                  selectedTextStyle: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontSize: 17.0,
                  ),
                  unselectedTextStyle: TextStyle(
                    color: dark ? Colors.white : Colors.black,
                    fontSize: 13.0,
                  ),
                  children: [
                    ValueListenableBuilder(
                      valueListenable: expense_graph_items,
                      builder: (context, value, child) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          child: value.length == 0
                              ? Center(child: Text("No Available Data"))
                              : SfCircularChart(
                                  series: <CircularSeries>[
                                    DoughnutSeries<ExpenseGraph, String>(
                                      dataSource: value,
                                      pointColorMapper:
                                          (ExpenseGraph data, index) =>
                                              data.color,
                                      xValueMapper:
                                          (ExpenseGraph data, index) =>
                                              data.title,
                                      yValueMapper:
                                          (ExpenseGraph data, index) =>
                                              data.value,
                                      dataLabelMapper:
                                          (ExpenseGraph data, index) =>
                                              data.title,
                                      animationDuration: 500,
                                      dataLabelSettings: DataLabelSettings(
                                        labelIntersectAction:
                                            LabelIntersectAction.shift,
                                        labelPosition:
                                            ChartDataLabelPosition.outside,
                                        isVisible: true,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: expenses_income_graph,
                      builder: (context, value, child) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          child: value.length == 0
                              ? Center(child: Text("No Available Data"))
                              : SfCircularChart(
                                  series: <CircularSeries>[
                                    DoughnutSeries<OverallStatsObject, String>(
                                      dataSource: value,
                                      pointColorMapper:
                                          (OverallStatsObject object, index) =>
                                              object.color,
                                      xValueMapper:
                                          (OverallStatsObject object, index) =>
                                              object.title,
                                      yValueMapper:
                                          (OverallStatsObject object, index) =>
                                              object.value,
                                      dataLabelMapper:
                                          (OverallStatsObject object, index) =>
                                              object.title,
                                      animationDuration: 500,
                                      dataLabelSettings: DataLabelSettings(
                                        labelIntersectAction:
                                            LabelIntersectAction.shift,
                                        labelPosition:
                                            ChartDataLabelPosition.outside,
                                        isVisible: true,
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15),
        ValueListenableBuilder(
          valueListenable: dark_mode,
          builder: (context, dark, child) {
            return ValueListenableBuilder(
              valueListenable: container_colors,
              builder: (context, decorate, child) {
                return Container(
                  height: 250,
                  width: 320,
                  decoration: decorate,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: date_label,
                          builder: (context, value, child) {
                            return Text(
                              "Date: ${value}",
                              style: TextStyleDisplay.main_text,
                            );
                          },
                        ),
                        ValueListenableBuilder(
                          valueListenable: total_date_overall,
                          builder: (context, value, child) {
                            return Text(
                              "Total: ${value >= 0 ? "+" : "-"}₱${value}",
                              style: value > 0
                                  ? TextStyleDisplay.income_text
                                  : TextStyleDisplay.expenses_text,
                            );
                          },
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
                            ValueListenableBuilder(
                              valueListenable: total_date_expenses,
                              builder: (context, value, child) {
                                return Text(
                                  "Expenses: -₱${value}",
                                  style: TextStyleDisplay.expenses_text,
                                );
                              },
                            ),
                            SizedBox(width: 30),
                            ValueListenableBuilder(
                              valueListenable: total_date_income,
                              builder: (context, value, child) {
                                return Text(
                                  "Income: +₱${value}",
                                  style: TextStyleDisplay.income_text,
                                );
                              },
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: dark ? Colors.white : Colors.black,
                          indent: 15,
                          endIndent: 15,
                        ),
                        ValueListenableBuilder(
                          valueListenable: statistics_overall,
                          builder: (context, expenses, child) {
                            return SingleChildScrollView(
                              child: Container(
                                color: Colors.transparent,
                                height: 130,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 40,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          AppDatabase.identify_icon(
                                                statistics_overall
                                                    .value[index]["category"],
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
                                            child: Text(
                                              expenses[index]["name"],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Text(
                                              style: expenses[index]["expense"]
                                                  ? TextStyleDisplay
                                                        .display_text_expense
                                                  : TextStyleDisplay
                                                        .display_text_income,
                                              "${expenses[index]["expense"] ? "-" : "+"}${expenses[index]["cost"]}",
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: statistics_overall.value.length,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
