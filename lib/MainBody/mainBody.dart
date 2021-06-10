import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'balanceView.dart';
import 'monthPlusMinus.dart';
import 'spendSpreadSheet.dart';
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
    return Center(
      child: Column(
        children: [
          SizedBox(height: 10),
          monthPlusMinus(viewModel),
          SizedBox(height: 10),
          balanceView(viewModel),
          SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  spendSpreadSheet(viewModel),
                  SizedBox(height: 40),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}