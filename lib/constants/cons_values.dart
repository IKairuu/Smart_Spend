import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:segmented_button_slide/segmented_button_slide.dart';
import 'package:smart_spend/Objects/message_func.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/views/add_expenses.dart';
import 'package:smart_spend/views/add_income.dart';
import 'package:smart_spend/views/add_memo.dart';
import 'package:smart_spend/views/display_view.dart';
import 'package:smart_spend/views/overall_stats.dart';
import 'package:smart_spend/views/expenses_stats.dart';
import 'package:smart_spend/views/read_memo.dart';
import 'package:smart_spend/views/remove_memo.dart';
import 'package:smart_spend/widgets/analysis_widget.dart';
import 'package:smart_spend/widgets/credentials_widget.dart';
import 'package:smart_spend/widgets/expenses_widget.dart';
import 'package:smart_spend/widgets/memo_widget.dart';
import 'package:smart_spend/views/remove_expenses.dart';
import 'package:smart_spend/widgets/statistics_widgets.dart';
import 'package:smart_spend/widgets/welcome_widget.dart';

class WelcomePageValues {
  static const List<Widget> welcome_pages = [
    WelcomeWidget(),
    CredentialsWidget(),
  ];

  static const List<String> genders = ["Male", "Female", "Rather not say"];
  static const List<String> gender_code = ["M", "F", "R"];
  static const List<Icon> gender_icon = [
    Icon(Icons.male_outlined),
    Icon(Icons.female_outlined),
    Icon(Icons.transgender_outlined),
  ];

  static const List<String> occupations = [
    "Employed",
    "Non-employed",
    "Business Owner",
    "Freelancer",
  ];

  static const List<String> occupations_code = ["E", "N", "B", "F"];
}

class MainPageValues {
  static const List<Widget> main_widgets = [
    ExpensesWidget(),
    StatisticsWidgets(),
    AnalysisWidget(),
    MemoWidget(),
  ];

  static const double displayBalancePadding = 25;
}

enum expenses_tab { DisplayExpenses, AddExpenses, RemoveExpenses, AddIncome }

class ExpensesTabs {
  static const Map<Enum, Widget> tabs = {
    expenses_tab.DisplayExpenses: DisplayView(),
    expenses_tab.AddExpenses: AddExpenses(),
    expenses_tab.RemoveExpenses: RemoveExpenses(),
    expenses_tab.AddIncome: AddIncome(),
  };

  static BoxDecoration expenses_tab_decoration = BoxDecoration(
    color: dark_mode.value ? Color.fromRGBO(46, 46, 46, 1) : Colors.white,
    borderRadius: BorderRadius.circular(20),
  );

  static InputDecoration field_decoration_light = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(208, 188, 254, 1),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  );
  static InputDecoration field_decoration_dark = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(73, 57, 113, 1),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  );
  static double field_width = 180;
  static double field_height = 40;

  static ButtonStyle button_decoration = ButtonStyle();

  static const double tab_paddings = 10;

  static String category = "default";

  static List<String> remove_items = [];
  static double total_balance = 0.00;
  static double total_expenses = 0.00;
  static double total_income = 0.00;
}

enum stats_tab { OverallTab, ExpenseTab }

class StatisticsPage {
  static List<SegmentedButtonSlideEntry> navigation_labels = [
    SegmentedButtonSlideEntry(
      icon: Icons.attach_money_rounded,
      label: "Expenses Graphs",
    ),
    SegmentedButtonSlideEntry(
      icon: Icons.group_work_outlined,
      label: "Overall Statistics",
    ),
    SegmentedButtonSlideEntry(icon: Icons.date_range, label: "Date"),
  ];

  static List<SegmentedButtonSlideEntry> price_index = [
    SegmentedButtonSlideEntry(label: "1k"),
    SegmentedButtonSlideEntry(label: "10k"),
    SegmentedButtonSlideEntry(label: "100k"),
    SegmentedButtonSlideEntry(label: "1M"),
  ];

  static List<stats_tab> list_tabs_stats = [
    stats_tab.OverallTab,
    stats_tab.ExpenseTab,
  ];
  static const Map<Enum, Widget> stats_views = {
    stats_tab.ExpenseTab: ExpensesStats(),
    stats_tab.OverallTab: OverallStats(),
  };

  static String date_selected = DateFormat.yMd()
      .format(DateTime.now())
      .toString();
}

class AnalysisTab {
  static List<Message> message_list = [
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: false),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime.now(), userSent: true),
    Message(text: "Hello", date: DateTime(2004, 9, 21), userSent: true),
  ];
}

class MemoTab {
  static List<Widget> memo_widgets = [AddMemo(), RemoveMemo(), ReadMemo()];
}

class Settings {
  static const String dark_mode = "dark_mode";
}

class TextStyleDisplay {
  static const TextStyle main_text = TextStyle(
    fontFamily: "Arial",
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle main_text_positive = TextStyle(
    fontFamily: "Arial",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static const TextStyle main_text_negative = TextStyle(
    fontFamily: "Arial",
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  static const TextStyle field_text = TextStyle(
    fontFamily: "Arial",
    fontSize: 17,
  );

  static const TextStyle expenses_text = TextStyle(
    fontFamily: "Arial",
    fontSize: 15,
    color: Colors.red,
  );

  static const TextStyle income_text = TextStyle(
    fontFamily: "Arial",
    fontSize: 15,
    color: Colors.green,
  );

  static final TextStyle display_text_expense = GoogleFonts.notoSerifOldUyghur(
    fontSize: 18,
    color: Colors.red,
  );
  static final TextStyle display_text_income = GoogleFonts.notoSerifOldUyghur(
    fontSize: 18,
    color: Colors.green,
  );

  static final TextStyle overall_balance_negative = TextStyle(
    fontSize: 20,
    color: Colors.red,
  );
  static final TextStyle overall_balance_positive = TextStyle(
    fontSize: 20,
    color: Colors.green,
  );

  static final TextStyle overall_graph_labels = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );
  static final TextStyle overall_graph_cost = TextStyle(
    color: Colors.red,
    fontSize: 20,
  );
  static final TextStyle settings_font = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle overall_labels = TextStyle(fontSize: 20);
}

class ColorContainer {
  static final Color main_containers_dark = Color.fromRGBO(46, 46, 46, 1);
  static final Color main_containers_light = Color.fromRGBO(208, 188, 254, 1);
  static final Color main_containers_indicator = Color.fromRGBO(73, 57, 113, 1);
  static final Color stats_main_color = Color.fromRGBO(232, 222, 248, 1);
  static final Color stats_tab_container = Color(0xFFF3E8FF);
  static final Color chat_box = Color.fromRGBO(208, 188, 254, 1);
}
