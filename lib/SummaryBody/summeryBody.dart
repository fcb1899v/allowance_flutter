import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'spendChart.dart';
import 'yearPlusMinus.dart';
import 'assetsChart.dart';
import 'balanceChart.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/admob.dart';

class summeryBody extends StatefulWidget {
  final mainViewModel viewModel;
  summeryBody(this.viewModel);
  @override
  _summeryBodyState createState() => _summeryBodyState(viewModel);
}

class _summeryBodyState extends State<summeryBody> {
  final mainViewModel viewModel;
  _summeryBodyState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          yearPlusMinus(viewModel),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  assetsChart(viewModel),
                  balanceChart(viewModel),
                  spendChart(viewModel),
                ],
              )
            )
          ),
          SizedBox(height: 10),
          adMobWidget(context),
        ],
      ),
    );
  }
}