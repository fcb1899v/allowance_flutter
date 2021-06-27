import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import 'chartWidget.dart';

class spendChart extends StatefulWidget {
  final mainViewModel viewModel;
  spendChart(this.viewModel);
  @override
  spendChartState createState() => spendChartState(viewModel);
}

class spendChartState extends State<spendChart> {
  final mainViewModel viewModel;
  spendChartState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final linechartbardatalist = [ lineChartBarData(
      List.generate(12, (index) => FlSpot(
        index.toDouble(), viewModel.spend[viewModel.yearindex][index]
      ),),
      Colors.lightBlue,
    ),];
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: gridData(),
          titlesData: titleData(viewModel.maxspend),
          borderData: borderData(),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: viewModel.maxspend.toMaxY(),
          lineBarsData: linechartbardatalist,
          axisTitleData: axisTitleData(
            AppLocalizations.of(context)!.moneyspent,
            AppLocalizations.of(context)!.month,
            viewModel.unitvalue,
          ),
        ),
      ),
    );
  }
}