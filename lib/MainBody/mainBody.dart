import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'balanceView.dart';
import 'monthPlusMinus.dart';
import 'spendSpreadSheet.dart';
import 'allowanceInputButton.dart';
import 'spendInputButton.dart';
import 'deleteButton.dart';
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
            SizedBox(height: 10),
            monthPlusMinus(viewModel),
            SizedBox(height: 10),
            balanceView(viewModel),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                allowanceInputButton(viewModel),
                Spacer(),
                spendInputButton(viewModel),
                Spacer(),
                deleteButton(viewModel),
                Spacer(),
                ],
            ),
            SizedBox(height: 20),
            spendSpreadSheet(viewModel),
          ]
        ),
      ),
    );
  }
}