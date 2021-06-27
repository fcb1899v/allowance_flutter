import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

class settingsName extends StatefulWidget{
  final mainViewModel viewModel;
  settingsName(this.viewModel);
  @override
  settingsNameState createState() => new settingsNameState(viewModel);
}

class settingsNameState extends State<settingsName> {
  final mainViewModel viewModel;
  settingsNameState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'defaultFont';
    final notset = AppLocalizations.of(context)!.notset;
    final name = (viewModel.name == "Not set") ? notset: viewModel.name;
    return ListTile(
      leading: Icon(CupertinoIcons.profile_circled),
      title: Text(AppLocalizations.of(context)!.name,
        style: settingsTextStyle(Colors.black, 16, customfont,),
      ),
      subtitle: Text(name,
        style: settingsTextStyle(Colors.grey, 16, customfont,),
      ),
      trailing: Icon(CupertinoIcons.forward),
      onTap: () {
        nameFieldDialog(context);
      },
    );
  }

  Future<void> nameFieldDialog(BuildContext context) async {
    String inputname = viewModel.name;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.settingnametitle
          ),
          content: TextField(
            onChanged: (value) {
              if (isNotBlank(value)) inputname = value;
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingnamehint,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: customTextStyle(Colors.lightBlue, 16, "defaultfont"),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text("OK",
                style: customTextStyle(Colors.lightBlue, 16, "defaultfont"),
              ),
              onPressed: () {
                if (isNotBlank(inputname)) {
                  viewModel.saveName(inputname);
                }
                setState(() {
                  viewModel.getName();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}