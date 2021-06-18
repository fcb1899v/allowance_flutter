import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';

class startDateView extends StatefulWidget{
  final mainViewModel viewModel;
  startDateView(this.viewModel);
  @override
  startDateViewState createState() => new startDateViewState(viewModel);
}

class startDateViewState extends State<startDateView> {
  final mainViewModel viewModel;
  startDateViewState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(CupertinoIcons.calendar_today),
      title: Text(AppLocalizations.of(context)!.startdate,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text("${viewModel.startdate}",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}