import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_spend/Objects/bar_chart_objects.dart';
import 'package:smart_spend/Objects/categories_chart.dart';
import 'package:smart_spend/Objects/memo_func.dart';
import 'package:smart_spend/Objects/overall_stats_object.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/Objects/database_functions.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/Objects/expense_graph.dart';

class AppDatabase {
  final BuildContext context;
  final Function fetchDataFunction;
  static final String box_name = "User_Box";
  static final String memo_box_name = "Memo_Box";

  AppDatabase({required this.context, required this.fetchDataFunction});
  static final hiveBox = Hive.box(box_name);
  static final memoHivebox = Hive.box(memo_box_name);

  static List<Map<dynamic, dynamic>> get_data() {
    List<Map<dynamic, dynamic>> data = [];
    for (int index = 0; index < hiveBox.values.length; index++) {
      if (hiveBox.values.elementAt(index)["date"] ==
          DateFormat.yMd().format(DateTime.now())) {
        data.add(hiveBox.values.elementAt(index));
      }
    }
    return data;
  }

  static Future<void> clear_data() async {
    try {
      await hiveBox.clear();
    } catch (error) {
      print("Failed to clear data");
    }
  }

  static Future<void> add_data(User_Data data) async {
    try {
      await hiveBox.add(data.create_map());
    } catch (error) {
      print("Failed to add data");
    }
  }

  static Future<void> edit_data(User_Data data, index) async {
    try {
      await hiveBox.put(index, data.create_map());
    } catch (error) {
      print("Failed to update data");
    }
  }

  static Future<void> delete_data(int index) async {
    try {
      await hiveBox.delete(index);
    } catch (error) {
      print("Failed to delete data");
    }
  }

  static int identify_key(String name, [bool expenses = true]) {
    int num_found = -1;
    switch (expenses) {
      case true:
        for (dynamic nums in hiveBox.keys) {
          if (hiveBox.get(nums)["name"] == name) {
            num_found = nums;
            break;
          }
        }
        break;
      case false:
        for (dynamic nums in memoHivebox.keys) {
          if (memoHivebox.get(nums)["title"] == name) {
            num_found = nums;
            break;
          }
        }
        break;
    }
    return num_found;
  }

  static void remove_items() {
    for (String names in remove_expenses_data.value) {
      final int index = AppDatabase.identify_key(names);
      AppDatabase.delete_data(index);
    }
    while (remove_expenses_data.value.isNotEmpty) {
      for (int index = 0; index < expenses_data.value.length; index++) {
        if (remove_expenses_data.value[0] ==
            expenses_data.value[index]["name"]) {
          expenses_data.value.removeAt(index);
          remove_expenses_data.value.removeAt(0);
          break;
        }
      }
    }
  }

  static List<MemoFunc> get_memo_data() {
    List<MemoFunc> data = [];
    for (int index = 0; index < memoHivebox.values.length; index++) {
      dynamic value = memoHivebox.values.elementAt(index);
      data.add(
        MemoFunc(
          title: value["title"],
          text: value["text"],
          date: value["date"],
        ),
      );
    }
    return data;
  }

  static Future<void> add_memo_data(MemoFunc data) async {
    try {
      await memoHivebox.add(data.create_map());
    } catch (error) {
      print("Error saving the memo: ${error}");
    }
  }

  static Future<void> clear_memo_data() async {
    try {
      await memoHivebox.clear();
    } catch (error) {
      print("Failed to clear data");
    }
  }

  static Future<void> delete_memo_data(int index) async {
    try {
      await memoHivebox.delete(index);
    } catch (error) {
      print("Error deleting memo: ${error}");
    }
  }

  static List<Map<bool, MemoFunc>> generate_check_box_memo() {
    List<Map<bool, MemoFunc>> data = [];
    for (int index = 0; index < memos.value.length; index++) {
      data.add({false: memos.value[index]});
    }
    return data;
  }

  static void calculate_all_display() {
    ExpensesTabs.total_balance = 0;
    ExpensesTabs.total_income = 0;
    ExpensesTabs.total_expenses = 0;
    print(expenses_data.value);
    for (int index = 0; index < expenses_data.value.length; index++) {
      if (expenses_data.value[index]["expense"] == true) {
        ExpensesTabs.total_balance -= expenses_data.value[index]["cost"];
        ExpensesTabs.total_expenses += expenses_data.value[index]["cost"];
      } else {
        ExpensesTabs.total_balance += expenses_data.value[index]["cost"];
        ExpensesTabs.total_income += expenses_data.value[index]["cost"];
      }
    }
  }

  static List<Map<dynamic, dynamic>> selected_items_date(
    String date, {
    bool expenses = true,
  }) {
    List<Map<dynamic, dynamic>> data = [];
    for (int index = 0; index < hiveBox.values.length; index++) {
      if (hiveBox.values.elementAt(index)["date"] == date &&
          (hiveBox.values.elementAt(index)["expense"] == true ||
              (hiveBox.values.elementAt(index)["expense"] == false &&
                  expenses == false))) {
        data.add(hiveBox.values.elementAt(index));
      }
    }

    return data;
  }

  static void calculate_date_expenses_income() {
    total_date_expenses.value = 0;
    total_date_income.value = 0;
    total_date_overall.value = 0;
    for (int index = 0; index < statistics_overall.value.length; index++) {
      if (statistics_overall.value[index]["expense"] == true) {
        total_date_expenses.value += statistics_overall.value[index]["cost"];
        total_date_overall.value -= statistics_overall.value[index]["cost"];
      } else {
        total_date_income.value += statistics_overall.value[index]["cost"];
        total_date_overall.value += statistics_overall.value[index]["cost"];
      }
    }
  }

  static List<ExpenseGraph> generate_expenses_chart() {
    List<ExpenseGraph> chart_data = [];
    Map<String, double> filtered_data = {};
    for (int index = 0; index < statistics_expenses.value.length; index++) {
      String category = statistics_expenses.value[index]["category"];
      double cost = statistics_expenses.value[index]["cost"];
      if (filtered_data.containsKey(category)) {
        filtered_data[category] = filtered_data[category]! + cost;
      } else {
        filtered_data[category] = cost;
      }
    }

    for (var value in filtered_data.entries) {
      chart_data.add(
        ExpenseGraph(
          title: value.key,
          value: value.value,
          color: chart_color_identifier(value.key) as Color,
        ),
      );
    }
    return chart_data;
  }

  static void refresh_data() {
    statistics_expenses.value = AppDatabase.selected_items_date(
      StatisticsPage.date_selected,
    );
    statistics_overall.value = AppDatabase.selected_items_date(
      StatisticsPage.date_selected,
      expenses: false,
    );
    date_label.value = DateFormat("MMMM d, yyyy")
        .format(DateFormat('MM/dd/yyyy').parse(StatisticsPage.date_selected))
        .toString();
    AppDatabase.calculate_date_expenses_income();
    expense_graph_items.value = AppDatabase.generate_expenses_chart();
    expenses_income_graph.value = [];
    if (total_date_expenses.value != 0 && total_date_income.value != 0) {
      expenses_income_graph.value.add(
        OverallStatsObject(
          title: "Income",
          value: total_date_income.value,
          color: Colors.green,
        ),
      );
      expenses_income_graph.value.add(
        OverallStatsObject(
          title: "Expenses",
          value: total_date_expenses.value,
          color: Colors.red,
        ),
      );
    }
  }

  static Color? chart_color_identifier(String category) {
    Map<String, Color> colors = {
      "Food": Color.fromRGBO(255, 112, 67, 1),
      "Transport": Color.fromRGBO(66, 165, 245, 1),
      "Groceries": Color.fromRGBO(102, 187, 106, 1),
      "Entertainment": Color.fromRGBO(171, 71, 188, 1),
      "Education": Color.fromRGBO(38, 198, 218, 1),
      "Bills": Color.fromRGBO(239, 83, 80, 1),
      "Health": Color.fromRGBO(236, 64, 122, 1),
      "Others": Color.fromRGBO(189, 189, 189, 1),
    };
    return colors[category];
  }

  static Icon? identify_icon(String icon) {
    Map<String, Icon> icons = {
      "Food": Icon(FontAwesomeIcons.bowlFood),
      "Transport": Icon(FontAwesomeIcons.car),
      "Groceries": Icon(Icons.food_bank_outlined),
      "Entertainment": Icon(Icons.gamepad),
      "Education": Icon(FontAwesomeIcons.book),
      "Bills": Icon(FontAwesomeIcons.moneyBill),
      "Health": Icon(Icons.healing),
      "Others": Icon(Icons.more_horiz_outlined),
      "default": Icon(Icons.add),
      "income": Icon(Icons.attach_money_rounded),
    };

    return icons[icon];
  }

  static void calculate_overall() {
    refresh_notifiers();
    Map<String, double> category = {};
    Map<String, double> chart_values = {"Expenses": 0.0, "Income": 0.0};
    Map<double, double> monthly_expenses_values = {
      1: 0,
      2: 0,
      3: 0,
      4: 0,
      5: 0,
      6: 0,
      7: 0,
      8: 0,
      9: 0,
      10: 0,
      11: 0,
      12: 0,
    };

    for (int index = 0; index < hiveBox.values.length; index++) {
      if (hiveBox.values.elementAt(index)["expense"]) {
        overall_balance.value -= hiveBox.values.elementAt(index)["cost"];
        net_savings.value -= hiveBox.values.elementAt(index)["cost"];
        overall_expenses.value += hiveBox.values.elementAt(index)["cost"];
        chart_values["Expenses"] =
            chart_values["Expenses"]! + hiveBox.values.elementAt(index)["cost"];
        double date = DateFormat(
          "MM/dd/yyyy",
        ).parse(hiveBox.values.elementAt(index)["date"]).month.toDouble();
        double year = DateFormat(
          "MM/dd/yyyy",
        ).parse(hiveBox.values.elementAt(index)["date"]).year.toDouble();

        if (((DateTime.now().month.toDouble() > 2) &&
                (DateTime.now().month.toDouble() - 2 == date ||
                    DateTime.now().month.toDouble() - 1 == date)) ||
            ((DateTime.now().month <= 2) &&
                (DateTime.now().month - 1 == date)) ||
            (DateTime.now().month == date) &&
                DateTime.now().year.toDouble() == year) {
          monthly_expenses_values[date] =
              monthly_expenses_values[date]! +
              hiveBox.values.elementAt(index)["cost"];
        }
      } else {
        overall_balance.value += hiveBox.values.elementAt(index)["cost"];
        overall_income.value += hiveBox.values.elementAt(index)["cost"];
        net_savings.value += hiveBox.values.elementAt(index)["cost"];
        chart_values["Income"] =
            chart_values["Income"]! + hiveBox.values.elementAt(index)["cost"];
      }

      String current_category = hiveBox.values.elementAt(index)["category"];
      if (category.containsKey(current_category) &&
          current_category != "income") {
        category[current_category] =
            category[current_category]! +
            hiveBox.values.elementAt(index)["cost"];
        category_expenses.value[current_category] =
            category_expenses.value[current_category]! +
            hiveBox.values.elementAt(index)["cost"];
      } else if (current_category != "income") {
        category[current_category] = hiveBox.values.elementAt(index)["cost"];
        category_expenses.value[current_category] =
            category_expenses.value[current_category]! +
            hiveBox.values.elementAt(index)["cost"];
      }
    }

    for (double obj in monthly_expenses_values.keys) {
      line_chart_spots.value.add(FlSpot(obj, monthly_expenses_values[obj]!));
    }
    print(line_chart_spots.value);

    if (category.isNotEmpty) {
      String? max_key;
      String? min_key;
      double max_value = -1;
      double min_value = 0;
      category.forEach((key, value) {
        if (max_value <= value) {
          max_value = value;
          max_key = key;
        }

        if (min_value == 0 || min_value > value) {
          min_value = value;
          min_key = key;
        }
        category_chart_data.value.add(
          CategoriesChart(
            title: key,
            value: value,
            color: chart_color_identifier(key)!,
          ),
        );
      });
      top_category.value = identify_icon(max_key!)!;
      least_category.value = identify_icon(min_key!)!;
    }
    bar_objects.value.add(
      BarChartObjects(
        title: "Expenses",
        position: 1,
        value: chart_values["Expenses"]!,
      ),
    );
    bar_objects.value.add(
      BarChartObjects(
        title: "Income",
        position: 2,
        value: chart_values["Income"]!,
      ),
    );
  }

  static void refresh_notifiers() {
    overall_balance.value = 0;
    overall_expenses.value = 0;
    overall_income.value = 0;
    net_savings.value = 0;
    top_category.value = Icon(null);
    least_category.value = Icon(null);
    bar_objects.value = [];
    category_chart_data.value = [];
    category_expenses.value = {
      "Food": 0.0,
      "Transport": 0.0,
      "Groceries": 0.0,
      "Entertainment": 0.0,
      "Education": 0.0,
      "Bills": 0.0,
      "Health": 0.0,
      "Others": 0.0,
    };
    line_chart_spots.value = [];
  }

  static bool identify_duplicates(String name, [bool expenses = true]) {
    if (expenses) {
      for (Map objects in expenses_data.value) {
        if (name == objects["name"]) {
          return true;
        }
      }
    } else {
      for (MemoFunc object in memos.value) {
        if (object.title == name) {
          return true;
        }
      }
    }
    return false;
  }
}
