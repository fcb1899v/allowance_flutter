import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';

class loginAppBar extends StatefulWidget implements PreferredSizeWidget{
  final mainViewModel viewModel;
  loginAppBar(this.viewModel);
  @override
  loginAppBarState createState() => new loginAppBarState(viewModel);
  @override
  final Size preferredSize = AppBar().preferredSize;
}

class loginAppBarState extends State<loginAppBar> {

  final mainViewModel viewModel;
  loginAppBarState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return AppBar(
      leading: (!viewModel.isMoveSignup) ? null: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            viewModel.moveLogin();
          });
        },
      ),
      title: Text(AppLocalizations.of(context)!.allowancebook,
        style: TextStyle(
          color: Colors.white,
          fontSize: (lang == "ja") ? 18: 24,
          fontWeight: FontWeight.bold,
          fontFamily: (lang == "ja") ? 'defaultfont': 'enAccent',
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurpleAccent,
              Theme.of(context).primaryColor
            ]
          ),
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        child: Container(
          color: Colors.white,
          height: 4.0,
        ),
        preferredSize: Size.fromHeight(4.0)
      ),
    );
  }
}

