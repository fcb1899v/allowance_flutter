import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';

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
    var lang = Localizations.localeOf(context).languageCode;
    final title = AppLocalizations.of(context)!.title;
    final allowancebook = AppLocalizations.of(context)!.allowancebook;
    return SizedBox(
      height: 100,
      child: DrawerHeader(
        child: TextButton(
          child: Text((viewModel.name == "Not set") ? allowancebook: "${viewModel.name}$title",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontFamily: (lang != "ja") ? 'Pacifico': 'Irohamaru',
            ),
            textAlign: TextAlign.start,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        decoration: BoxDecoration(
          color: Colors.lightBlue
        ),
      ),
    );
  }
}