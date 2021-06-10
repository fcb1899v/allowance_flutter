import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

class settingsAssets extends StatefulWidget{
  final mainViewModel viewModel;
  settingsAssets(this.viewModel);
  @override
  settingsAssetsState createState() => new settingsAssetsState(viewModel);
}

class settingsAssetsState extends State<settingsAssets> {
  final mainViewModel viewModel;
  settingsAssetsState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    final inputassets = AppLocalizations.of(context)!.notset;
    final numberdigit = (viewModel.unitvalue == '¥') ? 0: 2;
    final displayassets = (viewModel.startassets >= 0.0) ?
            "${viewModel.unitvalue} ${viewModel.startassets.toStringAsFixed(numberdigit)}":
            inputassets;
    return ListTile(
      leading: Icon(CupertinoIcons.money_dollar),
      title: Text(AppLocalizations.of(context)!.assets,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
          fontFamily: (lang == "ja") ? 'jaAccent': 'defaultFont',
        ),
      ),
      subtitle: Text(displayassets,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(CupertinoIcons.forward),
      onTap: () {
        allowanceFieldDialog(context);
      },
    );
  }

  Future<void> allowanceFieldDialog(BuildContext context) async {
    double inputassets = viewModel.startassets;
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
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text("OK",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (inputassets > 0) {
                  setState(() {
                    viewModel.saveStartAssets(inputassets);
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