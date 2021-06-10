import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

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
    return SpeedDial(
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
          backgroundColor: (id < 30) ? Colors.lightBlue: Colors.grey,
          onTap: () => {
            viewModel.increaseCounter(),
            spendInputDialog(context),
          },
          label: AppLocalizations.of(context)!.spend,
          labelBackgroundColor: (id < 30) ? Colors.lightBlue: Colors.grey,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SpeedDialChild(
          child: Icon(CupertinoIcons.money_dollar),
          foregroundColor: Colors.white,
          backgroundColor: (id < 30) ? Colors.pinkAccent: Colors.grey,
          onTap: () {
            viewModel.increaseCounter();
            allowanceInputDialog(context);
          },
          label: AppLocalizations.of(context)!.allowance,
          labelBackgroundColor: (id < 30) ? Colors.pinkAccent: Colors.grey,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Take a picture
      ],
    );
  }

  Future<void> spendInputDialog(BuildContext context) async {
    int inputday = 0;
    String inputdesc = "";
    double inputamnt = 0.0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.spend,
            style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (isNotBlank(value)) {
                    inputdesc = value;
                  } else {
                    inputdesc = "";
                  }
                  print("inputdesc: $inputdesc");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.desc,
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdeschint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                autofocus: true,
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value.toInt(0) > 0 && value.toInt(0) < 32) {
                    inputday = value.toInt(0);
                  } else {
                    inputday = 0;
                  }
                  print("inputday: $inputday");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.day,
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdatehint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value.toDouble(0) > 0) {
                    inputamnt = (-1.0) * value.toDouble(0);
                  } else {
                    inputamnt = 0;
                  }
                  print("inputamnt: $inputamnt");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.amnt} [${viewModel.unitvalue}]",
                  labelStyle: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingamnthint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  viewModel.decreaseCounter();
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text("OK",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (inputday > 0 && isNotBlank(inputdesc) && inputamnt != 0) {
                  setState(() {
                    print("counter: ${viewModel.counter[viewModel.index]}");
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

  Future<void> allowanceInputDialog(BuildContext context) async {
    int inputday = 0;
    String inputdesc = AppLocalizations.of(context)!.allowance;
    double inputamnt = 0.0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.allowance,
            style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value.toInt(0) > 0 && value.toInt(0) < 32) {
                    inputday = value.toInt(0);
                  } else {
                    inputday = 0;
                  }
                  print("inputday: $inputday");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.day,
                  labelStyle: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdatehint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                keyboardType: TextInputType.number,
                autofocus: true,
              ),
              SizedBox(height: 10),
              TextField(
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (value.toDouble(0) > 0) {
                    inputamnt = value.toDouble(0);
                  } else {
                    inputamnt = 0;
                  }
                  print("inputamnt: $inputamnt");
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: "${AppLocalizations.of(context)!.amnt} [${viewModel.unitvalue}]",
                  labelStyle: TextStyle(
                    color: Colors.pinkAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingamnthint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                viewModel.decreaseCounter();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("OK",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (inputday > 0 && inputamnt != 0) {
                  setState(() {
                    print("counter: ${viewModel.counter[viewModel.index]}");
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