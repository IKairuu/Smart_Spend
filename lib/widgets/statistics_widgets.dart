import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/functions/background.dart';

class StatisticsWidgets extends StatefulWidget {
  const StatisticsWidgets({super.key});

  @override
  State<StatisticsWidgets> createState() => _StatisticsWidgetsState();
}

class _StatisticsWidgetsState extends State<StatisticsWidgets> {
  DateTime? selected_date;
  Future<void> _datePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    setState(() {
      selected_date = pickedDate;
      String date_format = DateFormat.yMd().format(selected_date!).toString();
      StatisticsPage.date_selected = date_format;
      AppDatabase.refresh_data();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: stats_tab_view,
      builder: (context, value, child) {
        return Column(
          children: [
            ValueListenableBuilder(
              valueListenable: selected_tab_stats,
              builder: (context, index, child) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    width: 400,
                    child: Theme(
                      data: ThemeData(highlightColor: Colors.black),
                      child: ValueListenableBuilder(
                        valueListenable: dark_mode,
                        builder: (context, dark, child) {
                          return SegmentedButtonSlide(
                            entries: StatisticsPage.navigation_labels,
                            selectedEntry: index,
                            onChange: (selected) {
                              setState(() {
                                if (selected == 2) {
                                  _datePicker();
                                } else {
                                  selected_tab_stats.value = selected;
                                  stats_tab_view.value =
                                      StatisticsPage.list_tabs_stats[selected];
                                }
                              });
                            },
                            slideShadow: [
                              BoxShadow(
                                color: dark
                                    ? ColorContainer.main_containers_indicator
                                    : ColorContainer.stats_main_color,
                                blurRadius: 5,
                                spreadRadius: 1,
                              ),
                            ],
                            selectedTextStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                              fontSize: 17,
                            ),
                            unselectedTextStyle: TextStyle(
                              color: dark ? Colors.white : Colors.black,
                              fontSize: 15,
                            ),
                            colors: SegmentedButtonSlideColors(
                              barColor: dark
                                  ? ColorContainer.main_containers_dark
                                  : Colors.white,
                              backgroundSelectedColor: dark
                                  ? ColorContainer.main_containers_indicator
                                  : ColorContainer.stats_main_color,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            ?StatisticsPage.stats_views[value],
          ],
        );
      },
    );
  }
}
