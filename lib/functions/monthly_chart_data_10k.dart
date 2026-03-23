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

Widget total_labels_10k(double value, TitleMeta meta) {
  String text = switch (value.toInt()) {
    1000 => "1k",
    2000 => "2k",
    3000 => "3k",
    4000 => "4k",
    5000 => "5k",
    6000 => "6k",
    7000 => "7k",
    8000 => "8k",
    9000 => "9k",
    10000 => "10k",
    _ => "",
  };
  return SideTitleWidget(child: Text(text), meta: meta);
}

LineChartData monthly_expenses_10k(List<FlSpot> data) {
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
          interval: 2000,
          getTitlesWidget: total_labels_10k,
        ),
      ),
    ),
    lineBarsData: [LineChartBarData(spots: data, isCurved: true)],
    minX: DateTime.now().month.toDouble() == 2
        ? DateTime.now().month.toDouble() - 1
        : DateTime.now().month.toDouble() - 2,
    maxX: DateTime.now().month.toDouble(),
    minY: 1,
    maxY: 10000,
  );
}
