import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import '../DrawerView/drawerView.dart';
import 'mainAppBar.dart';
import 'balanceView.dart';
import 'spendSpreadSheet.dart';
import 'counterPlusMinus.dart';
import 'mainViewModel.dart';

class AllowancePage extends StatefulWidget {
  final mainViewModel viewModel;
  AllowancePage(this.viewModel);
  @override
  _AllowancePageState createState() => _AllowancePageState(viewModel);
}

class _AllowancePageState extends State<AllowancePage> {
  final mainViewModel viewModel;
  _AllowancePageState(this.viewModel);

  @override
  void initState() {
    super.initState();
    setState(() {
      viewModel.init();
    });
  }

  @override
  void dispose() {
    super.dispose();
    setState(() {
      viewModel.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<mainViewModel>(
      model: viewModel,
      child: ScopedModelDescendant<mainViewModel>(
        builder: (context, child, model) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  Colors.deepPurpleAccent,
                  Theme.of(context).primaryColor,
                ]
            ),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: mainAppBar(viewModel),
            drawer: drawerView(viewModel),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      balanceView(viewModel),
                      SizedBox(height: 30),
                      counterPlusMinus(viewModel),
                      SizedBox(height: 50),
                      spendSpreadSheet(viewModel),
                    ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}