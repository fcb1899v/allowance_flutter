import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mainViewModel.dart';

class mainBottomAppBar extends StatefulWidget {
  final mainViewModel viewModel;
  mainBottomAppBar(this.viewModel);
  @override
  mainBottomAppBarState createState() => new mainBottomAppBarState(viewModel);
}

class mainBottomAppBarState extends State<mainBottomAppBar> {
  final mainViewModel viewModel;
  mainBottomAppBarState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.white,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: <Widget>[
            Spacer(),
            IconButton(
              color: (viewModel.selectflag) ? Colors.lightBlue: Colors.grey[400],
              icon: Icon(CupertinoIcons.calendar),
              tooltip: AppLocalizations.of(context)!.list,
              onPressed: () {
                setState(() {
                  viewModel.changeSelectFlag();
                });
              },
            ),
            Spacer(),
            IconButton(
              color: (!viewModel.selectflag) ? Colors.lightBlue: Colors.grey[400],
              icon: Icon(Icons.summarize_sharp),
              tooltip: AppLocalizations.of(context)!.summary,
              onPressed: () {
                setState(() {
                  viewModel.changeSelectFlag();
                });
              },
            ),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}