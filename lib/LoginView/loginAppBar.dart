import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

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
    return AppBar(
      leading: (viewModel.isMoveSignup) ? IconButton(
        icon: Icon(CupertinoIcons.back, color: Colors.white,),
        onPressed: () {
          setState(() {viewModel.moveLogin();});
        },
      ): null,
      automaticallyImplyLeading: false,
      title: titleView(context,
        AppLocalizations.of(context)!.allowancebook,
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

