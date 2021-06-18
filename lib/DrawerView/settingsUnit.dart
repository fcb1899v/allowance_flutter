import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiver/strings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';

class settingsUnit extends StatefulWidget{
  final mainViewModel viewModel;
  settingsUnit(this.viewModel);
  @override
  settingsUnitState createState() => new settingsUnitState(viewModel);
}

class settingsUnitState extends State<settingsUnit> {
  final mainViewModel viewModel;
  settingsUnitState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(CupertinoIcons.money_dollar_circle),
      title: Text(AppLocalizations.of(context)!.unit,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text("${viewModel.unitvalue}",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(CupertinoIcons.forward),
      onTap: () {
        unitDropDownListDialog(context);
      },
    );
  }

  Future<void> unitDropDownListDialog(BuildContext context) async {
    String selectunit = viewModel.unitvalue;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settingunittitle),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton <String>(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    value: selectunit,
                    onChanged: (String? newValue) {
                      if (isNotBlank(selectunit)) {
                        setState(() {
                          selectunit = newValue!;
                        });
                      }
                    },
                    items: <String>["¥", "\$", "€", "£",]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
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
                if (isNotBlank(selectunit)) {
                  viewModel.saveUnit(selectunit);
                }
                setState(() {
                  viewModel.getUnit();
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