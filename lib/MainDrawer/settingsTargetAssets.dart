import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class settingsTargetAssets extends StatefulWidget{
  final mainViewModel viewModel;
  settingsTargetAssets(this.viewModel);
  @override
  settingsTargetAssetsState createState() => new settingsTargetAssetsState(viewModel);
}

class settingsTargetAssetsState extends State<settingsTargetAssets> {
  final mainViewModel viewModel;
  settingsTargetAssetsState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? 'jaAccent': 'defaultFont';
    final numberdigit = (viewModel.unitvalue == '¥') ? 0: 2;
    final displayunit = (viewModel.targetassets >= 0.0) ? "${viewModel.unitvalue} ": "";
    final displayassets = (viewModel.targetassets >= 0.0) ?
            "${viewModel.targetassets.toStringAsFixed(numberdigit)}":
            AppLocalizations.of(context)!.notset;
    return ListTile(
      leading: Icon(CupertinoIcons.money_dollar),
      title: Text(AppLocalizations.of(context)!.targetassets,
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
        setTargetAssetsDialog(context);
      },
    );
  }

  Future<void> setTargetAssetsDialog(BuildContext context) async {
    double inputassets = viewModel.targetassets;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settingtargettitle,),
          content: TextField(
            onChanged: (value) {
              if (value.toDouble(0.0) >= 0.0) {
                inputassets = value.toDouble(0.0);
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingtargethint,
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
                    viewModel.saveTargetAssets(inputassets);
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