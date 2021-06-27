import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

class descTextFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  descTextFieldView(this.viewModel, this.id);
  @override
  descTextFieldViewState createState() => new descTextFieldViewState(viewModel);
}

class descTextFieldViewState extends State<descTextFieldView> {

  final mainViewModel viewModel;
  descTextFieldViewState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    int i = viewModel.index;
    String description = viewModel.spendlist[i][widget.id]["desc"];
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    Color? customcolor = (isBlank(description)) ? Colors.grey:
             (amount < 0.0) ? Colors.lightBlue: Colors.pinkAccent;
    return InkWell(
      onTap: () => {
        if (widget.id != viewModel.counter[i] - 1 && amount < 0.0) {
          descFieldDialog(context)
        },
      },
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((isNotBlank(description)) ? description: "-",
            style: customTextStyle(customcolor, 14, "defaultfont"),
            maxLines: 1,
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }

  Future<void> descFieldDialog(BuildContext context) async {
    int i = viewModel.index;
    String inputtext = "";
    String description = viewModel.spendlist[i][widget.id]["desc"];
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    Color? customcolor = (isBlank(description)) ? Colors.grey:
             (amount < 0.0) ? Colors.lightBlue: Colors.pinkAccent;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.spend,
            style: customTextStyle(customcolor, 16, "defaultfont"),
          ),
          content: TextField(
            style: customTextStyle(customcolor, 14, "defaultfont"),
            onChanged: (value) {
              if (isNotBlank(value)) inputtext = value;
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customcolor, width: 1.0),
              ),
              hintText: AppLocalizations.of(context)!.settingdeschint,
              hintStyle: customTextStyle(Colors.grey, 14, "defaultfont"),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel,
                style: customTextStyle(customcolor, 14, "defaultfont"),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text("OK",
                style: customTextStyle(customcolor, 14, "defaultfont"),
              ),
              onPressed: () {
                if (isNotBlank(inputtext)) {
                  setState(() {
                    viewModel.saveDescList(widget.id, inputtext);
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
