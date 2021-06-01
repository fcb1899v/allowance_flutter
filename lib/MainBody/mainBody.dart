import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'balanceView.dart';
import 'spendSpreadSheet.dart';
import 'counterPlusMinus.dart';
import '../MainView/mainViewModel.dart';

class mainBody extends StatefulWidget {
  final mainViewModel viewModel;
  mainBody(this.viewModel);
  @override
  _mainBodyState createState() => _mainBodyState(viewModel);
}

class _mainBodyState extends State<mainBody> {
  final mainViewModel viewModel;
  _mainBodyState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 60),
            balanceView(viewModel),
            SizedBox(height: 30),
            counterPlusMinus(viewModel),
            SizedBox(height: 60),
            spendSpreadSheet(viewModel),
          ]
        ),
      ),
    );
  }
}