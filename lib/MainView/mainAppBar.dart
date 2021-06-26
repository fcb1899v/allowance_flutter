import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'commonWidget.dart';
import 'mainPopupMenuButton.dart';
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
    return AppBar(
      leading: (viewModel.selectflag) ? IconButton(
        icon: Icon(Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ): null,
      automaticallyImplyLeading: false,
        title: titleView(context,
          (viewModel.selectflag) ?
          AppLocalizations.of(context)!.list:
          AppLocalizations.of(context)!.summary,
      ),
      actions: [mainPopupMenuButton(viewModel)],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurpleAccent,
              Theme.of(context).primaryColor,
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
      )
    );
  }
}

