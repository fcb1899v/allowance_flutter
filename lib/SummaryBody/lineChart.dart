import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import '../MainView/mainViewModel.dart';

class lineChart extends StatefulWidget {
  final mainViewModel viewModel;
  lineChart(this.viewModel);
  @override
  _lineChartState createState() => _lineChartState(viewModel);
}

class _lineChartState extends State<lineChart> {
  final mainViewModel viewModel;
  _lineChartState(this.viewModel);

  List<Color> gradientColors = [
    Colors.lightBlue,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width - 50,
      child: LineChart(
        LineChartData(
          gridData: _griddata(),
          titlesData: _titledata(),
          borderData: _bordardata(),
          minX: viewModel.maxindex.toDouble(),
          maxX: 0,
          minY: 0,
          maxY: viewModel.allowance,
          lineBarsData: _linechartbardatalist(),
        ),
      ),
    );
  }

  FlGridData _griddata() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.white,
          strokeWidth: 1,
        );
      },
    );
  }

  FlTitlesData _titledata() {
    return FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 22,
        getTextStyles: (value) => const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        margin: 8,
      ),
      leftTitles: SideTitles(
        showTitles: true,
        getTextStyles: (value) => const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        getTitles: (value) {
          switch (value.toInt()) {
            case 0: return '0';
            case 100: return '100';
            case 200: return '200';
            case 300: return '300';
            case 400: return '400';
            case 500: return '500';
          }
          return '';
        },
        reservedSize: 28,
        margin: 12,
      ),
    );
  }

  FlBorderData _bordardata() {
    return FlBorderData(
      show: true,
      border: Border.all(
        color: Colors.white,
        width: 1
      ),
    );
  }

  List<LineChartBarData> _linechartbardatalist() {

    List<FlSpot> flspotlist = List.generate(viewModel.maxindex,
      (index) => FlSpot(index.toDouble(), viewModel.balancelist[index].toDouble())
    );

    return [
      LineChartBarData(
        spots: flspotlist,
        //isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
        colors: [
          ColorTween(
              begin: Colors.lightBlue,
              end: Colors.white
          ).lerp(0.2)!,
          ColorTween(
              begin: Colors.lightBlue,
              end: Colors.white
          ).lerp(0.2)!,
        ],
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          colors: [
            ColorTween(
              begin: Colors.lightBlue,
              end: Colors.white
            ).lerp(0.2)!.withOpacity(0.5),
            ColorTween(
              begin: Colors.lightBlue,
              end: Colors.white
            ).lerp(0.2)!.withOpacity(0.5),
          ],
        ),
      ),
    ];
  }
}