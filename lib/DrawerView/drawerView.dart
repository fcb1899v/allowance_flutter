import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MainView/mainViewModel.dart';
import 'drawerHeader.dart';
import 'settingsName.dart';
import 'settingsUnit.dart';
import 'settingsAllowance.dart';
import 'startDateView.dart';
import 'versionView.dart';

class drawerView extends StatefulWidget{
  final mainViewModel viewModel;
  drawerView(this.viewModel);
  @override
  drawerViewState createState() => new drawerViewState(viewModel);
}

class drawerViewState extends State<drawerView> {
  final mainViewModel viewModel;
  drawerViewState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              drawerHeader(viewModel),
              SizedBox(height: 10),
              settingsName(viewModel),
              settingsUnit(viewModel),
              settingsAllowance(viewModel),
              startDateView(viewModel),
              versionView(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}