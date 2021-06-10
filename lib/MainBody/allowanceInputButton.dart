import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

class allowanceInputButton extends StatefulWidget{
  final mainViewModel viewModel;
  allowanceInputButton(this.viewModel);
  @override
  allowanceInputButtonState createState() => new allowanceInputButtonState(viewModel);
}

class allowanceInputButtonState extends State<allowanceInputButton> {

  final mainViewModel viewModel;
  allowanceInputButtonState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    final id = viewModel.counter[viewModel.index] - 1;
    return FloatingActionButton(
      backgroundColor: (id < 30) ? Colors.pinkAccent: Colors.grey,
      onPressed: () {
        setState((){
          viewModel.increaseCounter();
          allowanceInputDialog(context);
        });
      },
      child: Icon(CupertinoIcons.gift),
      tooltip: 'allowance',
      heroTag: "hero1",
    );
  }

  Widget buttonText(String text){
    return Text(text,
      style: TextStyle(
        color: Colors.pinkAccent,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
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
