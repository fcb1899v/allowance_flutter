import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MainView/mainViewModel.dart';
import 'lineChart.dart';
import 'yearPlusMinus.dart';

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
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            yearPlusMinus(viewModel),
            SizedBox(height: 10),
            lineChart(viewModel),
            SizedBox(height: 10),
          ]
        ),
      ),
    );
  }
}