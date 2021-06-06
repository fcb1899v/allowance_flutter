import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

class spendInputButton extends StatefulWidget{
  final mainViewModel viewModel;
  spendInputButton(this.viewModel);
  @override
  spendInputButtonState createState() => new spendInputButtonState(viewModel);
}

class spendInputButtonState extends State<spendInputButton> {

  final mainViewModel viewModel;
  spendInputButtonState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    final id = viewModel.counter[viewModel.index] - 1;
    return FloatingActionButton(
      backgroundColor: (id < 30) ? Colors.lightBlue: Colors.grey,
      onPressed: () {
        setState((){
          viewModel.increaseCounter();
          spendInputDialog(context);
        });
      },
      child: Icon(CupertinoIcons.shopping_cart),
      tooltip: 'income',
      heroTag: "hero1",
    );
  }

  Future<void> spendInputDialog(BuildContext context) async {
    final int i = viewModel.index;
    final int id = viewModel.counter[i];
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
                  color: Colors.lightBlue,
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
                  hintText: AppLocalizations.of(context)!.enter,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                autofocus: true,
              ),
              SizedBox(height: 5),
              TextField(
                style: TextStyle(
                  color: Colors.lightBlue,
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
                  hintText: AppLocalizations.of(context)!.enter,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 5),
              TextField(
                style: TextStyle(
                  color: Colors.lightBlue,
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
                  hintText: AppLocalizations.of(context)!.enter,
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
                if (inputday != 0 && isNotBlank(inputdesc) && inputamnt != 0) {
                  setState(() {
                    viewModel.saveDateList(id - 1, inputday);
                    viewModel.saveDescList(id - 1, inputdesc);
                    viewModel.saveAmntList(id - 1, inputamnt);
                  });
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
