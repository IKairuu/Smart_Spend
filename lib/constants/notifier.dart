import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend/Objects/bar_chart_objects.dart';
import 'package:smart_spend/Objects/categories_chart.dart';
import 'package:smart_spend/Objects/memo_func.dart';
import 'package:smart_spend/Objects/overall_stats_object.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/expense_graph.dart';

ValueNotifier<int> current_widget = ValueNotifier(0);
ValueNotifier<int> current_main_widget = ValueNotifier(0);
ValueNotifier<int> current_expenses_view = ValueNotifier(0);
ValueNotifier<expenses_tab> view = ValueNotifier(expenses_tab.DisplayExpenses);
ValueNotifier<int> selected_tab_stats = ValueNotifier(0);
ValueNotifier<stats_tab> stats_tab_view = ValueNotifier(stats_tab.OverallTab);
ValueNotifier<List<Map<dynamic, dynamic>>> expenses_data = ValueNotifier([]);
ValueNotifier<List<String>> remove_expenses_data = ValueNotifier([]);
ValueNotifier<List<Map<dynamic, dynamic>>> statistics_expenses = ValueNotifier(
  [],
);
ValueNotifier<List<Map<dynamic, dynamic>>> statistics_overall = ValueNotifier(
  [],
);
ValueNotifier<double> total_date_expenses = ValueNotifier(0);
ValueNotifier<double> total_date_income = ValueNotifier(0);
ValueNotifier<double> total_date_overall = ValueNotifier(0);
ValueNotifier<String> date_label = ValueNotifier(
  DateFormat("MMMM d, yyyy").format(DateTime.now()).toString(),
);
ValueNotifier<List<ExpenseGraph>> expense_graph_items = ValueNotifier([]);
ValueNotifier<List<OverallStatsObject>> expenses_income_graph = ValueNotifier(
  [],
);
ValueNotifier<double> overall_balance = ValueNotifier(0);
ValueNotifier<double> overall_expenses = ValueNotifier(0);
ValueNotifier<double> overall_income = ValueNotifier(0);
ValueNotifier<double> net_savings = ValueNotifier(0);
ValueNotifier<Icon> top_category = ValueNotifier(Icon(null));
ValueNotifier<Icon> least_category = ValueNotifier(Icon(null));
ValueNotifier<List<BarChartObjects>> bar_objects = ValueNotifier([]);
ValueNotifier<List<CategoriesChart>> category_chart_data = ValueNotifier([]);
ValueNotifier<Map<String, double>> category_expenses = ValueNotifier({
  "Food": 0.0,
  "Transport": 0.0,
  "Groceries": 0.0,
  "Entertainment": 0.0,
  "Education": 0.0,
  "Bills": 0.0,
  "Health": 0.0,
  "Others": 0.0,
});
ValueNotifier<List<FlSpot>> line_chart_spots = ValueNotifier([]);
ValueNotifier<int> price_index = ValueNotifier(0);
ValueNotifier<int> memo_view = ValueNotifier(0);
ValueNotifier<List<MemoFunc>> memos = ValueNotifier([]);
ValueNotifier<String> selected_memo_title = ValueNotifier("");
ValueNotifier<String> selected_memo_text = ValueNotifier("");
ValueNotifier<List<Map<bool, MemoFunc>>> memo_check_data = ValueNotifier([]);
ValueNotifier<List<String?>> to_delete_memo = ValueNotifier([]);
ValueNotifier<bool> dark_mode = ValueNotifier(false);
ValueNotifier<BoxDecoration> container_colors = ValueNotifier(
  BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
);
