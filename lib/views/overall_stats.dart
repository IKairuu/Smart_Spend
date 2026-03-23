import 'package:flutter/material.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/views/graph_view.dart';
import 'package:smart_spend/views/information_view.dart';
import 'package:tab_container/tab_container.dart';

class ExpensesStats extends StatefulWidget {
  const ExpensesStats({super.key});

  @override
  State<ExpensesStats> createState() => _ExpensesStatsState();
}

class _ExpensesStatsState extends State<ExpensesStats> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Column(
          children: [
            ValueListenableBuilder(
              valueListenable: container_colors,
              builder: (context, decorate, child) {
                return Container(
                  height: 520,
                  width: 320,
                  decoration: decorate,
                  child: ValueListenableBuilder(
                    valueListenable: dark_mode,
                    builder: (context, dark, child) {
                      return TabContainer(
                        tabs: [Text("Information"), Text("Graph")],
                        borderRadius: BorderRadius.circular(20),
                        tabBorderRadius: BorderRadius.circular(20),
                        tabMaxLength: double.infinity,
                        colors: [
                          dark
                              ? ColorContainer.main_containers_indicator
                              : ColorContainer.stats_tab_container,
                          dark
                              ? ColorContainer.main_containers_indicator
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
                        children: [InformationView(), GraphView()],
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
