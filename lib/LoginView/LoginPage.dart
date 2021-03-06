import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import 'loginAppBar.dart';
import 'loginBody.dart';

class LoginPage extends StatefulWidget {
  final mainViewModel viewModel;
  LoginPage(this.viewModel);
  @override
  _LoginPageState createState() => _LoginPageState(viewModel);
}

class _LoginPageState extends State<LoginPage> {
  final mainViewModel viewModel;
  _LoginPageState(this.viewModel);

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {
        if (FirebaseAuth.instance.currentUser != null) {
          pushPage(context, "/h",);
        }
      });
    });
    if (mounted) {
      setState(() {
        viewModel.init();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _LoginPageState(viewModel);
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
            appBar: loginAppBar(viewModel),
            body: loginBody(viewModel),
          ),
        ),
      ),
    );
  }
}