import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

class balanceChart extends StatefulWidget {
  final mainViewModel viewModel;
  balanceChart(this.viewModel);
  @override
  balanceChartState createState() => balanceChartState(viewModel);
}

class balanceChartState extends State<balanceChart> {
  final mainViewModel viewModel;
  balanceChartState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final deltay = (viewModel.maxbalance ~/ 500 * 100 != 0) ? viewModel.maxbalance ~/ 500 * 100: 100;
    return Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: LineChart(
          LineChartData(
            gridData: _griddata(),
            titlesData: _titledata(),
            borderData: _bordardata(),
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: (viewModel.maxbalance ~/ deltay + 1.0) * deltay,
            lineBarsData: _linechartbardatalist(),
            axisTitleData: _axistitledata(),
          ),
        ),
      );
  }

  FlGridData _griddata() {
    final yflline = FlLine(
      color: Colors.grey,
      strokeWidth: 1,
    );
    final xflline = FlLine(
      color: Colors.grey,
      strokeWidth: 1,
    );
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) => yflline,
      getDrawingVerticalLine: (value) => xflline,
    );
  }

  FlTitlesData _titledata() {
    final textstyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final deltay = viewModel.maxbalance ~/ 500 * 100;
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 20,
        getTextStyles: (value) => textstyle,
        margin: 10,
        getTitles: (value) => "${(value.toInt() + 1).toString().addZero()}",
      ),
      leftTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        margin: 15,
        getTextStyles: (value) => textstyle,
        getTitles: (value) {
          if (value.toInt() % deltay == 0 && value.toInt() < 1000) {
            return "${value.toInt()}";
          } else if (value.toInt() % deltay == 0) {
            return "${(value.toInt() / 1000).toStringAsFixed(0)}k";
          } else {
            return '';
          }
        }
      ),
    );
  }

  FlBorderData _bordardata() {
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

  FlAxisTitleData _axistitledata() {
    return FlAxisTitleData(
      topTitle: AxisTitle(
        showTitle: true,
        titleText: "${AppLocalizations.of(context)!.savedmoney} [${viewModel.unitvalue}]",
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'defaultfont',
        ),
        margin: 10,
      ),
      bottomTitle: AxisTitle(
        showTitle: true,
        margin: 5,
        titleText: AppLocalizations.of(context)!.month,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: "defaultfont",
        ),
      ),
    );
  }

  List<LineChartBarData> _linechartbardatalist() {
    List<FlSpot> flspotlist = List.generate(12,
      (index) => FlSpot(index.toDouble(), viewModel.balance[viewModel.yearindex][index])
    );
    return [ LineChartBarData(
      spots: flspotlist,
      isCurved: false,
      barWidth: 5,
      isStrokeCapRound: true,
      colors: [Colors.pinkAccent],
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: [Colors.pinkAccent.withOpacity(0.5)],
      ),
    ),];
  }
}