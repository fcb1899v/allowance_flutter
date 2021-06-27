import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

FlGridData gridData() {
  return FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: true,
    getDrawingHorizontalLine: (_) => FlLine(color: Colors.grey, strokeWidth: 1,),
    getDrawingVerticalLine: (_) => FlLine(color: Colors.grey, strokeWidth: 1,),
  );
}

FlBorderData borderData() {
  return FlBorderData(
    show: true,
    border: const Border(
      left: BorderSide(color: Colors.white, width: 1),
      top: BorderSide(color: Colors.white, width: 1),
      bottom: BorderSide(color: Colors.white, width: 1),
      right: BorderSide(color: Colors.white, width: 1),
    ),
  );
}

FlAxisTitleData axisTitleData(String toptitle, String bottomtitle, String unit) {
  return FlAxisTitleData(
    topTitle: AxisTitle(
      showTitle: true,
      margin: 10,
      titleText: "$toptitle [$unit]",
      textStyle: customTextStyle(Colors.white, 20, 'Roboto'),
    ),
    bottomTitle: AxisTitle(
      showTitle: true,
      margin: 5,
      titleText: bottomtitle,
      textStyle: customTextStyle(Colors.white, 16, 'Roboto'),
    ),
  );
}

FlTitlesData titleData(double max) {
  return FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 20,
      margin: 10,
      getTextStyles: (_) => customTextStyle(Colors.white, 14, 'Roboto'),
      getTitles: (value) => value.bottomTitleValue(),
    ),
    leftTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      margin: 15,
      getTextStyles: (_) => customTextStyle(Colors.white, 14, 'Roboto'),
      getTitles: (value) => value.leftTitleValue(max),
    ),
  );
}

LineChartBarData lineChartBarData(List<FlSpot> flspotlist, Color color) {
  return LineChartBarData(
    spots: flspotlist,
    isCurved: false,
    barWidth: 5,
    isStrokeCapRound: true,
    colors: [color],
    dotData: FlDotData(show: true,),
    belowBarData: BarAreaData(
      show: true,
      colors: [color.withOpacity(0.5)],
    ),
  );
}

LineChartBarData lineChartTargetData(List<FlSpot> flspotlist, Color color) {
  return LineChartBarData(
    spots: flspotlist,
    isCurved: false,
    barWidth: 5,
    isStrokeCapRound: true,
    colors: [color],
    dotData: FlDotData(show: false,),
  );
}

extension DoubleExt on double {

  double toDeltaY() {
    if (this >= 500) {
      return this ~/ 500 * 100;
    } else if (this >= 50) {
      return this ~/ 50 * 10;
    } else if (this >= 5) {
      return this ~/ 5 * 1;
    } else {
      return 1;
    }
  }

  double toMaxY() {
    double deltay = this.toDeltaY();
    return (this ~/ deltay + 1.0) * deltay;
  }

  String bottomTitleValue() {
    return "${(this.toInt() + 1).toString().addZero()}";
  }

  String leftTitleValue(double max) {
    double deltay = max.toDeltaY();
    if (this.toInt() % deltay == 0.0 && deltay >= 2000) {
      return "${(this.toDouble() / 1000).toStringAsFixed(0)}k";
    } else if (this.toDouble() % deltay == 0.0 && deltay >= 500) {
      return "${(this.toDouble() / 1000).toStringAsFixed(1)}k";
    } else if (this.toDouble() % deltay == 0.0) {
      return "${this.toDouble().toStringAsFixed(0)}";
    } else {
      return '';
    }
  }
}
