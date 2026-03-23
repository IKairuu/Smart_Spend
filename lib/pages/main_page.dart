import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';
import 'package:smart_spend/pages/settings_page.dart';
import 'package:smart_spend/widgets/main_background_day.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dark_mode,
      builder: (context, dark, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: dark
                ? ColorContainer.main_containers_dark
                : ColorContainer.main_containers_light,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.menu),
              color: dark ? Colors.white : Colors.black,
            ),
            title: Text(
              "SmartSpend",
              style: TextStyle(color: dark ? Colors.white : Colors.black),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  });
                },
                icon: Icon(Icons.settings),
                color: dark ? Colors.white : Colors.black,
              ),
            ],
          ),
          body: ValueListenableBuilder(
            valueListenable: current_main_widget,
            builder: (context, value, child) {
              return Stack(
                children: [
                  MainBackgroundDay(),
                  SingleChildScrollView(
                    child: MainPageValues.main_widgets[value],
                  ),
                ],
              );
            },
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              indicatorColor: dark
                  ? ColorContainer.main_containers_light
                  : ColorContainer.main_containers_indicator,
              iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((
                states,
              ) {
                return IconThemeData(
                  color: dark
                      ? (states.contains(MaterialState.selected)
                            ? Colors.black
                            : Colors.white)
                      : (states.contains(MaterialState.selected)
                            ? Colors.white
                            : Colors.black),
                );
              }),
            ),
            child: NavigationBar(
              backgroundColor: dark
                  ? ColorContainer.main_containers_dark
                  : ColorContainer.main_containers_light,
              selectedIndex: current_main_widget.value,
              onDestinationSelected: (value) {
                setState(() {
                  current_main_widget.value = value;
                });
              },
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.money),
                  label: "Expenses",
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_sharp),
                  label: "Statistics",
                ),
                NavigationDestination(
                  icon: Icon(FontAwesomeIcons.robot),
                  label: "AI Analysis",
                ),
                NavigationDestination(
                  icon: Icon(FontAwesomeIcons.noteSticky),
                  label: "Memo",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
