import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'mainAppBar.dart';
import 'balanceView.dart';
import 'mainViewModel.dart';
import 'spendSpreadSheet.dart';
import 'counterPlusMinus.dart';

class AllowancePage extends StatefulWidget {
  final mainViewModel viewModel;
  AllowancePage(this.viewModel);
  @override
  _AllowancePageState createState() => _AllowancePageState(viewModel);
}

class _AllowancePageState extends State<AllowancePage> {
  final mainViewModel viewModel;
  _AllowancePageState(this.viewModel);
  var allowance = "500";

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<mainViewModel>(
        model: viewModel,
        child: ScopedModelDescendant<mainViewModel>(
            builder: (context, child, model) =>
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Colors.deepPurpleAccent,
                      Theme.of(context).primaryColor,
                    ]
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: mainAppBar(),
                  body: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 50),
                        balanceView(viewModel, allowance),
                        SizedBox(height: 60),
                        spendSpreadSheet(viewModel),
                        SizedBox(height: 30),
                        counterPlusMinus(viewModel),
                      ]
                    ),
                  ),
                ),
              ),
        ),
    );
  }
}