import 'package:flutter/material.dart';
import 'package:smart_spend/Objects/bar_chart_objects.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InformationView extends StatefulWidget {
  const InformationView({super.key});

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: overall_balance,
              builder: (context, balance, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Overall Balance: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    Text(
                      "${balance > 0 ? "+" : "-"}₱${balance.abs().toString()}",
                      style: balance > 0
                          ? TextStyleDisplay.overall_balance_positive
                          : TextStyleDisplay.overall_balance_negative,
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: overall_expenses,
              builder: (context, expenses, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Total Expenses: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    Text(
                      "-₱${expenses.toString()}",
                      style: TextStyleDisplay.overall_balance_negative,
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: overall_income,
              builder: (context, income, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Total Income: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    Text(
                      "+₱${income.toString()}",
                      style: TextStyleDisplay.overall_balance_positive,
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: net_savings,
              builder: (context, savings, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Net Savings: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    Text(
                      "${savings >= 0 ? "+" : "-"}₱${savings.abs().toString()}",
                      style: savings > 0
                          ? TextStyleDisplay.overall_balance_positive
                          : TextStyleDisplay.overall_balance_negative,
                    ),
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: top_category,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Top Category: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    value,
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: least_category,
              builder: (context, value, child) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Least Category: ",
                          style: TextStyleDisplay.overall_labels,
                        ),
                      ),
                    ),
                    value,
                  ],
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: bar_objects,
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: container_colors,
                      builder: (context, decorate, child) {
                        return Container(
                          decoration: decorate,
                          height: 200,
                          width: double.infinity,
                          child: value.length > 0
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    series:
                                        <
                                          CartesianSeries<
                                            BarChartObjects,
                                            String
                                          >
                                        >[
                                          BarSeries<BarChartObjects, String>(
                                            dataSource: value,
                                            dataLabelMapper:
                                                (BarChartObjects data, index) =>
                                                    data.title,
                                            xValueMapper:
                                                (BarChartObjects data, index) =>
                                                    data.title,
                                            yValueMapper:
                                                (BarChartObjects data, index) =>
                                                    data.value,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ],
                                  ),
                                )
                              : Center(child: Text("No Available Data")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
