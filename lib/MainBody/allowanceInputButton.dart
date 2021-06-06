import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
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
      backgroundColor: (id < 30) ? Colors.lightBlue: Colors.grey,
      onPressed: () {
        setState((){
          viewModel.increaseCounter();
          viewModel.saveDescList(id, AppLocalizations.of(context)!.allowance);
          spendInputDialog(context);
        });
      },
      child: Icon(CupertinoIcons.gift),
      tooltip: 'allowance',
    );
  }

  Widget buttonText(String text){
    return Text(text,
      style: TextStyle(
        color: Colors.lightBlue,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Future<void> spendInputDialog(BuildContext context) async {
    final int i = viewModel.index;
    final int id = viewModel.counter[i];
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
                  color: Colors.lightBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  if (isNotBlank(value)) {
                    viewModel.saveDateList(id - 1, value.toInt(1));
                  }
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.day,
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
                    viewModel.saveAmntList(id - 1, value.toDouble(0));
                  }
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
                autofocus: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: buttonText(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                setState(() {
                  viewModel.saveDateList(id - 1, 0);
                  viewModel.saveDescList(id - 1, "");
                  viewModel.saveAmntList(id - 1, 0.0);
                  viewModel.decreaseCounter();
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: buttonText("OK"),
              onPressed: () {
                setState(() {
                  viewModel.getDateList();
                  viewModel.getDescList();
                  viewModel.getAmntList();
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
