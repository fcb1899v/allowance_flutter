import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'mainViewModel.dart';
import 'mainAppBar.dart';
import 'mainBottomNavi.dart';
import '/MainBody/mainBody.dart';
import '/MainBody/inputButtons.dart';
import '/MainDrawer/mainDrawer.dart';
import '/SummaryBody/summeryBody.dart';

class MainHomePage extends StatefulWidget {
  final mainViewModel viewModel;
  MainHomePage(this.viewModel);
  @override
  _MainHomePageState createState() => _MainHomePageState(viewModel);
}

class _MainHomePageState extends State<MainHomePage> {
  final mainViewModel viewModel;
  _MainHomePageState(this.viewModel);

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      if (mounted) {
        setState(() {
          viewModel.init();
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _MainHomePageState(viewModel);
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
            drawer: mainDrawer(viewModel),
            bottomNavigationBar: (viewModel.isLogin) ? mainBottomNavi(viewModel): null,
            body: (viewModel.selectflag) ? mainBody(viewModel): summeryBody(viewModel),
            floatingActionButton: (viewModel.selectflag) ? inputButtons(viewModel): null,
          ),
        ),
      ),
    );
  }
}