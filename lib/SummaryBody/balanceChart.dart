import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import 'chartWidget.dart';

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
    final linechartbardatalist = [ lineChartBarData(
      List.generate(12, (index) => FlSpot(
        index.toDouble(), viewModel.balance[viewModel.yearindex][index]
      ),),
      Colors.pinkAccent,
    ),];
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: gridData(),
          titlesData: titleData(viewModel.maxbalance),
          borderData: borderData(),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: viewModel.maxbalance.toMaxY(),
          lineBarsData: linechartbardatalist,
          axisTitleData: axisTitleData(
            AppLocalizations.of(context)!.moneyleft,
            AppLocalizations.of(context)!.month,
            viewModel.unitvalue,
          ),
        ),
      ),
    );
  }
}