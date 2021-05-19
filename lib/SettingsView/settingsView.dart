import 'package:allowance_app/SettingsView/settingsListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:allowance_app/MainView/mainViewModel.dart';
import 'settingsAppBar.dart';

class settingsView extends StatefulWidget{
  final mainViewModel viewModel;
  settingsView(this.viewModel);
  @override
  settingsViewState createState() => new settingsViewState(viewModel);
}

class settingsViewState extends State<settingsView> {

  final mainViewModel viewModel;
  settingsViewState(this.viewModel);

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
            appBar: settingsAppBar(),
            body: settingsListView(viewModel),
          ),
        ),
      ),
    );
  }
}