import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';
import '../extension.dart';

class settingsAllowance extends StatefulWidget{
  final mainViewModel viewModel;
  settingsAllowance(this.viewModel);
  @override
  settingsAllowanceState createState() => new settingsAllowanceState(viewModel);
}

class settingsAllowanceState extends State<settingsAllowance> {
  final mainViewModel viewModel;
  settingsAllowanceState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(CupertinoIcons.money_dollar),
      title: Text(AppLocalizations.of(context)!.allowance,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text("${viewModel.unitvalue} ${viewModel.allowance}",
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
    int inputallowance = viewModel.allowance;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settingallowancetitle),
          content: TextField(
            onChanged: (value) {
              if (value.toInt(0) > 0) {
                inputallowance = value.toInt(0);
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.settingallowancehint),
            keyboardType: TextInputType.number,
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
                if (inputallowance > 0) {
                  viewModel.saveAllowance(inputallowance);
                }
                setState(() {
                  viewModel.getAllowance();
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