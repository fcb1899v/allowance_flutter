import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

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
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'defaultFont';
    return ListTile(
      leading: Icon(CupertinoIcons.calendar_today),
      title: Text(AppLocalizations.of(context)!.startdate,
        style: settingsTextStyle(Colors.black, 16, customfont,),
      ),
      subtitle: Text("${viewModel.startdate}",
        style: settingsTextStyle(Colors.grey, 16, customfont,),
      ),
    );
  }
}