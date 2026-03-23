import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget month_labels(double value, TitleMeta meta) {
  String text = switch (value.toInt()) {
    1 => "Jan",
    2 => "Feb",
    3 => "Mar",
    4 => "Apr",
    5 => "May",
    6 => "Jun",
    7 => "Jul",
    8 => "Aug",
    9 => "Sept",
    10 => "Oct",
    11 => "Nov",
    12 => "Dec",
    _ => "",
  };
  return SideTitleWidget(child: Text(text), meta: meta);
}

Widget total_labels_1M(double value, TitleMeta meta) {
  String text = switch (value.toInt()) {
    100000 => "100k",
    200000 => "200k",
    300000 => "300k",
    400000 => "400k",
    500000 => "500k",
    600000 => "600k",
    700000 => "700k",
    800000 => "800k",
    900000 => "900k",
    1000000 => "1M",
    _ => "",
  };
  return SideTitleWidget(child: Text(text), meta: meta);
}

LineChartData monthly_expenses_1M(List<FlSpot> data) {
  return LineChartData(
    clipData: FlClipData.all(),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          interval: 1,
          getTitlesWidget: month_labels,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          reservedSize: 40,
          showTitles: true,
          interval: 200000,
          getTitlesWidget: total_labels_1M,
        ),
      ),
    ),
    lineBarsData: [LineChartBarData(spots: data, isCurved: true)],
    minX: DateTime.now().month.toDouble() == 2
        ? DateTime.now().month.toDouble() - 1
        : DateTime.now().month.toDouble() - 2,
    maxX: DateTime.now().month.toDouble(),
    minY: 1,
    maxY: 1000000,
  );
}
