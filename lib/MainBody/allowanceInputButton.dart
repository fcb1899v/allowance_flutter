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

  Widget spendInputTitle(String title) {
    return Container(
      width: double.infinity,
      child: Text(title,
        style: TextStyle(fontSize: 20,),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buttonText(String text){
    return Text(text,
      style: TextStyle(
        color: Colors.lightBlue,
        fontSize: 16,
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
          title: spendInputTitle(AppLocalizations.of(context)!.date),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  if (isNotBlank(value)) {
                    viewModel.saveDateList(id - 1, value.toInt(1));
                  }
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.settingdatehint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
              SizedBox(height: 30),
              spendInputTitle("${AppLocalizations.of(context)!.settingamnttitle} [${viewModel.unitvalue}]"),
              SizedBox(height: 15),
              TextField(
                onChanged: (value) {
                  if (value.toDouble(0) > 0) {
                    viewModel.saveAmntList(id - 1, value.toDouble(0));
                  }
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.settingamnthint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
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
