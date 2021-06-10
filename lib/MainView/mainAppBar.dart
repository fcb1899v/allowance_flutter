import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mainViewModel.dart';

class mainAppBar extends StatefulWidget implements PreferredSizeWidget{
  final mainViewModel viewModel;
  mainAppBar(this.viewModel);
  @override
  mainAppBarState createState() => new mainAppBarState(viewModel);
  @override
  final Size preferredSize = AppBar().preferredSize;
}

class mainAppBarState extends State<mainAppBar> {

  final mainViewModel viewModel;
  mainAppBarState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text((viewModel.selectflag) ?
               AppLocalizations.of(context)!.list:
               AppLocalizations.of(context)!.summary,
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

