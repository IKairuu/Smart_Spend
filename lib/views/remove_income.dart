import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_spend/constants/cons_values.dart';

class RemoveIncome extends StatefulWidget {
  const RemoveIncome({super.key});

  @override
  State<RemoveIncome> createState() => _RemoveIncomeState();
}

class _RemoveIncomeState extends State<RemoveIncome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MainPageValues.displayBalancePadding),
      child: Column(
        children: [
          SizedBox(height: 60),
          Container(
            height: 250,
            decoration: ExpensesTabs.expenses_tab_decoration,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.trash),
              label: const Text("Remove"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color.fromRGBO(73, 57, 113, 1),
                backgroundColor: Color.fromRGBO(247, 242, 250, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                fixedSize: const Size(310, 40),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
