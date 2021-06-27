import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

class versionView extends StatefulWidget{
  final mainViewModel viewModel;
  versionView(this.viewModel);
  @override
  versionViewState createState() => new versionViewState(viewModel);
}

class versionViewState extends State<versionView> {
  final mainViewModel viewModel;
  versionViewState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'defaultFont';
    return ListTile(
      leading: Icon(CupertinoIcons.app),
      title: Text(AppLocalizations.of(context)!.version,
        style: settingsTextStyle(Colors.black, 16, customfont,),
      ),
      subtitle: Text("${viewModel.version}",
        style: settingsTextStyle(Colors.grey, 16, customfont,),
      ),
    );
  }
}