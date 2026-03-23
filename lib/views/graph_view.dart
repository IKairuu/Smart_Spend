import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:smart_spend/Objects/categories_chart.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/monthly_chart_data_100k.dart';
import 'package:smart_spend/functions/monthly_chart_data_10k.dart';
import 'package:smart_spend/functions/monthly_chart_data_1M.dart';
import 'package:smart_spend/functions/monthly_chart_data_1k.dart';
import 'package:smart_spend/views/list_graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphView extends StatefulWidget {
  const GraphView({super.key});

  @override
  State<GraphView> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ValueListenableBuilder(
        valueListenable: dark_mode,
        builder: (context, dark, child) {
          return Container(
            height: double.infinity,
            width: double.infinity,
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: category_chart_data,
                      builder: (context, value, child) {
                        return ValueListenableBuilder(
                          valueListenable: container_colors,
                          builder: (context, decorate, child) {
                            return Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                height: 250,
                                width: 270,
                                decoration: decorate,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 30,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: dark
                                              ? ColorContainer
                                                    .main_containers_light
                                              : ColorContainer
                                                    .main_containers_indicator,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 1,
                                              right: 1,
                                            ),
                                            child: Text(
                                              "Category of Expenses",
                                              style: TextStyle(
                                                color: dark
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 210,
                                      width: double.infinity,
                                      child: value.length == 0
                                          ? Center(
                                              child: Text("No Available Data"),
                                            )
                                          : SfCircularChart(
                                              series: <CircularSeries>[
                                                PieSeries<
                                                  CategoriesChart,
                                                  String
                                                >(
                                                  dataSource: value,
                                                  pointColorMapper:
                                                      (
                                                        CategoriesChart data,
                                                        index,
                                                      ) => data.color,
                                                  dataLabelMapper:
                                                      (
                                                        CategoriesChart data,
                                                        index,
                                                      ) => data.title,
                                                  xValueMapper:
                                                      (
                                                        CategoriesChart data,
                                                        index,
                                                      ) => data.title,
                                                  yValueMapper:
                                                      (
                                                        CategoriesChart data,
                                                        index,
                                                      ) => data.value,
                                                  dataLabelSettings:
                                                      DataLabelSettings(
                                                        isVisible: true,
                                                        labelIntersectAction:
                                                            LabelIntersectAction
                                                                .shift,
                                                        labelPosition:
                                                            ChartDataLabelPosition
                                                                .outside,
                                                      ),
                                                ),
                                              ],
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
                    ListGraph(),
                    ValueListenableBuilder(
                      valueListenable: price_index,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            right: 20,
                            left: 20,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: container_colors,
                            builder: (context, decorate, child) {
                              return Container(
                                height: 260,
                                width: 270,
                                decoration: decorate,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 30,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: dark
                                              ? ColorContainer
                                                    .main_containers_light
                                              : ColorContainer
                                                    .main_containers_indicator,
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 1,
                                              right: 1,
                                            ),
                                            child: Text(
                                              "Monthly Expenses",
                                              style: TextStyle(
                                                color: dark
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: ValueListenableBuilder(
                                        valueListenable: line_chart_spots,
                                        builder: (context, data, child) {
                                          return SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: LineChart(
                                              value == 0
                                                  ? monthly_expenses_1k(data)
                                                  : value == 1
                                                  ? monthly_expenses_10k(data)
                                                  : value == 2
                                                  ? monthly_expenses_100k(data)
                                                  : monthly_expenses_1M(data),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: price_index,
                      builder: (context, index, child) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 5,
                            bottom: 5,
                          ),
                          child: Container(
                            width: 250,
                            child: Theme(
                              data: ThemeData(highlightColor: Colors.black),
                              child: SegmentedButtonSlide(
                                entries: StatisticsPage.price_index,
                                selectedEntry: index,
                                onChange: (selected) {
                                  setState(() {});
                                  price_index.value = selected;
                                },
                                height: 30,
                                slideShadow: [
                                  BoxShadow(
                                    color: ColorContainer.main_containers_light,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                  ),
                                ],
                                selectedTextStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                                unselectedTextStyle: TextStyle(
                                  color: dark ? Colors.white : Colors.black,
                                  fontSize: 12,
                                ),
                                colors: SegmentedButtonSlideColors(
                                  barColor: dark
                                      ? ColorContainer.main_containers_dark
                                      : ColorContainer.stats_tab_container,
                                  backgroundSelectedColor:
                                      ColorContainer.main_containers_light,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
