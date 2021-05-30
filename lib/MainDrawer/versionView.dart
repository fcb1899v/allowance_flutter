import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';

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
    var lang = Localizations.localeOf(context).languageCode;
    return ListTile(
      leading: Icon(CupertinoIcons.app),
      title: Text(AppLocalizations.of(context)!.version,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontFamily: (lang == "ja") ? 'jaAccent': 'defaultFont',
        ),
      ),
      subtitle: Text("${viewModel.version}",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}