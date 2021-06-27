import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import 'chartWidget.dart';

class assetsChart extends StatefulWidget {
  final mainViewModel viewModel;
  assetsChart(this.viewModel);
  @override
  assetsChartState createState() => assetsChartState(viewModel);
}

class assetsChartState extends State<assetsChart> {
  final mainViewModel viewModel;
  assetsChartState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final linechartbardatalist = [
      lineChartBarData(
        List.generate(12, (index) => FlSpot(
          index.toDouble(), viewModel.assets[viewModel.yearindex][index]
        )),
        Colors.deepPurpleAccent,
      ),
      if (viewModel.targetassets > 0.0) lineChartTargetData(
        List.generate(12, (index) => FlSpot(
          index.toDouble(), viewModel.targetassets
        )),
        Colors.lightBlue,
      ),
    ];
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20),
      child: LineChart(
        LineChartData(
          gridData: gridData(),
          titlesData: titleData(viewModel.maxassets),
          borderData: borderData(),
          minX: 0,
          maxX: 11,
          minY: 0,
          maxY: viewModel.maxassets.toMaxY(),
          lineBarsData: linechartbardatalist,
          axisTitleData: axisTitleData(
            AppLocalizations.of(context)!.assets,
            AppLocalizations.of(context)!.month,
            viewModel.unitvalue,
          ),
        ),
      ),
    );
  }
}