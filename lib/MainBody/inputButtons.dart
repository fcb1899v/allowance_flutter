import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class inputButtons extends StatefulWidget {
  final mainViewModel viewModel;
  inputButtons(this.viewModel);
  @override
  _inputButtonsState createState() => _inputButtonsState(viewModel);
}

class _inputButtonsState extends State<inputButtons> {
  final mainViewModel viewModel;
  _inputButtonsState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    final id = viewModel.counter[viewModel.index] - 1;
    Color customcolor(int i, bool flag) =>
      (i >= 30) ? Colors.grey: (!flag) ? Colors.lightBlue: Colors.pinkAccent;
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: SpeedDial(
        icon: CupertinoIcons.plus,
        activeIcon: Icons.close,
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue,
        curve: Curves.bounceIn,
        children: [
          // Select file
          SpeedDialChild(
            child: Icon(CupertinoIcons.gift),
            foregroundColor: Colors.white,
            backgroundColor: customcolor(id, false),
            onTap: () => {
              viewModel.increaseCounter(),
              spendInputDialog(context, false),
            },
            label: AppLocalizations.of(context)!.spend,
            labelBackgroundColor: customcolor(id, false),
            labelStyle: customTextStyle(Colors.white, 16, "defaultfont"),
          ),
          SpeedDialChild(
            child: Icon(CupertinoIcons.money_dollar),
            foregroundColor: Colors.white,
            backgroundColor: customcolor(id, true),
            onTap: () {
              viewModel.increaseCounter();
              spendInputDialog(context, true);
            },
            label: AppLocalizations.of(context)!.allowance,
            labelBackgroundColor: customcolor(id, true),
            labelStyle: customTextStyle(Colors.white, 16, "defaultfont"),
          ),
          // Take a picture
        ],
      ),
    );
  }

  Future<void> spendInputDialog(BuildContext context, bool spendflag) async {
    int inputday = 0;
    String inputdesc = AppLocalizations.of(context)!.allowance;
    double inputamnt = 0.0;
    String title = (spendflag) ?
             AppLocalizations.of(context)!.allowance:
             AppLocalizations.of(context)!.spend;
    Color customcolor = (spendflag) ? Colors.pinkAccent: Colors.lightBlue;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title,
            style: customTextStyle(customcolor, 16, "defaultfont"),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: customTextStyle(customcolor, 14, "defaultfont"),
                onChanged: (value) {
                  final intvalue = value.toInt(0);
                  inputday = (intvalue > 0 && intvalue < 32) ? intvalue: 0;
                  print("inputday: $inputday");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.day,
                  labelStyle: customTextStyle(customcolor, 14, "defaultfont"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customcolor, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdatehint,
                  hintStyle: customTextStyle(Colors.grey, 14, "defaultfont"),
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
              ),
              if (!spendflag) SizedBox(height: 10),
              if (!spendflag) TextField(
                style: customTextStyle(customcolor, 14, "defaultfont"),
                onChanged: (value) {
                  inputdesc = (isNotBlank(value)) ? value: "";
                  print("inputdesc: $inputdesc");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.desc,
                  labelStyle: customTextStyle(customcolor, 14, "defaultfont"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customcolor, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdeschint,
                  hintStyle: customTextStyle(Colors.grey, 14, "defaultfont"),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                style: customTextStyle(customcolor, 14, "defaultfont"),
                onChanged: (value) {
                  final plusminus = (spendflag) ? 1.0: -1.0;
                  final doublevalue = value.toDouble(0);
                  inputamnt = (doublevalue > 0.0) ? plusminus * doublevalue: 0.0;
                  print("inputamnt: $inputamnt");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.amnt} [${viewModel.unitvalue}]",
                  labelStyle: customTextStyle(customcolor, 14, "defaultfont"),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: customcolor, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingamnthint,
                  hintStyle: customTextStyle(Colors.grey, 14, "defaultfont"),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: customTextStyle(customcolor, 14, "defaultfont"),
              ),
              onPressed: () {
                setState(() {
                  viewModel.decreaseCounter();
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.ok,
                style: customTextStyle(customcolor, 14, "defaultfont"),
              ),
              onPressed: () {
                if (!spendflag && inputdesc == AppLocalizations.of(context)!.allowance) {
                  inputdesc = "";
                }
                if (inputday > 0 && isNotBlank(inputdesc) && inputamnt != 0) {
                  setState(() {
                    viewModel.saveSpendList(inputday, inputdesc, inputamnt);
                  });
                  //viewModel.selectDate(context, id - 1);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }
}