import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class settingsInitialAssets extends StatefulWidget{
  final mainViewModel viewModel;
  settingsInitialAssets(this.viewModel);
  @override
  settingsInitialAssetsState createState() => new settingsInitialAssetsState(viewModel);
}

class settingsInitialAssetsState extends State<settingsInitialAssets> {
  final mainViewModel viewModel;
  settingsInitialAssetsState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'defaultFont';
    final numberdigit = (viewModel.unitvalue == '¥') ? 0: 2;
    final displayunit = (viewModel.initialassets >= 0.0) ? "${viewModel.unitvalue} ": "";
    final displayassets = (viewModel.initialassets >= 0.0) ?
            "${viewModel.initialassets.toStringAsFixed(numberdigit)}":
            AppLocalizations.of(context)!.notset;
    return ListTile(
      leading: Icon(CupertinoIcons.money_dollar),
      title: Text(AppLocalizations.of(context)!.initialassets,
        style: settingsTextStyle(Colors.black, 16, customfont,),
      ),
      subtitle: Row(
        children: [
          Text(displayunit,
            style: settingsTextStyle(Colors.grey, 16, "Roboto"),
          ),
          Text(displayassets,
            style: settingsTextStyle(Colors.grey, 16, customfont),
          ),
        ],
      ),
      trailing: Icon(CupertinoIcons.forward),
      onTap: () {
        setInitialAssetsDialog(context);
      },
    );
  }

  Future<void> setInitialAssetsDialog(BuildContext context) async {
    double inputassets = viewModel.initialassets;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settingassetstitle,),
          content: TextField(
            onChanged: (value) {
              if (value.toDouble(0.0) >= 0.0) {
                inputassets = value.toDouble(0.0);
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingassetshint,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            keyboardType: TextInputType.number,
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
                style: customTextStyle(Colors.lightBlue, 16, "defaultfont"),),
              onPressed: () {
                if (inputassets >= 0.0) {
                  setState(() {
                    viewModel.saveInitialAssets(inputassets);
                    viewModel.getAssets();
                  });
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}