import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User_Data extends Equatable {
  final String? date;
  final String? name;
  final String? category;
  final double? cost;
  final bool? expenses;
  bool? selected;

  User_Data({
    required this.date,
    required this.name,
    required this.category,
    required this.cost,
    required this.expenses,
    required this.selected,
  });

  @override
  List<Object?> get props => [date, name, category, cost, expenses, selected];

  Map<dynamic, dynamic> create_map() {
    return {
      "date": date,
      "name": name,
      "category": category,
      "cost": cost,
      "expense": expenses,
      "selected": selected,
    };
  }
}
