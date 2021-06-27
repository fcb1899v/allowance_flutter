import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

class drawerHeader extends StatefulWidget{
  final mainViewModel viewModel;
  drawerHeader(this.viewModel);
  @override
  drawerHeaderState createState() => new drawerHeaderState(viewModel);
}

class drawerHeaderState extends State<drawerHeader> {
  final mainViewModel viewModel;
  drawerHeaderState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'enAccent';
    final allowancebook = (viewModel.name == "Not set") ?
            AppLocalizations.of(context)!.allowancebook:
            "${viewModel.name}${AppLocalizations.of(context)!.title}";
    return SizedBox(
      height: 100,
      child: DrawerHeader(
        child: TextButton(
          child: Text(allowancebook,
            style: customTextStyle(Colors.white, 20, customfont),
            textAlign: TextAlign.start,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        decoration: BoxDecoration(color: Colors.lightBlue),
      ),
    );
  }
}