import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_spend/constants/cons_values.dart';
import 'package:smart_spend/constants/notifier.dart';

class ListGraph extends StatefulWidget {
  const ListGraph({super.key});

  @override
  State<ListGraph> createState() => _ListGraphState();
}

class _ListGraphState extends State<ListGraph> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: category_expenses,
      builder: (context, category, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: ValueListenableBuilder(
            valueListenable: container_colors,
            builder: (context, decorate, child) {
              return Container(
                height: 260,
                decoration: decorate,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.bowlFood),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Food")),
                            Text(
                              "-₱${category["Food"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.car),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Transport")),
                            Text(
                              "-₱${category["Transport"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.food_bank_outlined),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Groceries")),
                            Text(
                              "-₱${category["Groceries"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.gamepad),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Entertainment")),
                            Text(
                              "-₱${category["Entertainment"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.book),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Education")),
                            Text(
                              "-₱${category["Education"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.moneyBill),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Bills")),
                            Text(
                              "-₱${category["Bills"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.healing),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Health")),
                            Text(
                              "-₱${category["Health"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 30,
                        child: Row(
                          children: [
                            Icon(Icons.more_horiz_outlined),
                            VerticalDivider(
                              thickness: 2,
                              color: Colors.black,
                              endIndent: 2,
                              indent: 2,
                            ),
                            Expanded(child: Text("Others")),
                            Text(
                              "-₱${category["Others"]}",
                              style: TextStyleDisplay.overall_balance_negative,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
