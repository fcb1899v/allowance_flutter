import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/MainView/mainViewModel.dart';
import 'drawerHeader.dart';
import 'settingsName.dart';
import 'settingsUnit.dart';
import 'settingsAllowance.dart';
import 'startDateView.dart';
import 'versionView.dart';

class mainDrawer extends StatefulWidget{
  final mainViewModel viewModel;
  mainDrawer(this.viewModel);
  @override
  mainDrawerState createState() => new mainDrawerState(viewModel);
}

class mainDrawerState extends State<mainDrawer> {
  final mainViewModel viewModel;
  mainDrawerState(this.viewModel);

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
              //settingsAllowance(viewModel),
              startDateView(viewModel),
              versionView(viewModel),
            ],
          ),
        ),
      ),
    );
  }
}