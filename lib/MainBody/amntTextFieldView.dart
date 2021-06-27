import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class amntTextFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  amntTextFieldView(this.viewModel, this.id);
  @override
  amntTextFieldViewState createState() => new amntTextFieldViewState(viewModel);
}

class amntTextFieldViewState extends State<amntTextFieldView> {

  final mainViewModel viewModel;
  amntTextFieldViewState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    int i = viewModel.index;
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    final customcolor = (amount == 0.0) ? Colors.grey: (amount < 0.0) ?
            Colors.lightBlue: Colors.pinkAccent;
    return InkWell(
      onTap: () => {
        if (widget.id != viewModel.counter[i] - 1 || amount != 0.0) {
          amntFieldDialog(context)
        },
      },
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((amount == 0.0) ? "-": amount.stringAmount(viewModel.unitvalue),
            style: customTextStyle(customcolor, 14, "defaultfont"),
            textAlign: TextAlign.right,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Future<void> amntFieldDialog(BuildContext context) async {
    int i = viewModel.index;
    double inputamnt = 0.0;
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    double plusminus = (amount < 0) ? -1.0: 1.0;
    Color? customcolor = (amount == 0.0) ? Colors.grey: (amount < 0.0) ?
                          Colors.lightBlue: Colors.pinkAccent;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.amnt,
            style: customTextStyle(customcolor, 16, "defaultfont"),
          ),
          content: TextField(
            style: customTextStyle(customcolor, 14, "defaultfont"),
            onChanged: (value) {
              if (value.toDouble(0.0) > 0.0) {
                inputamnt = plusminus * value.toDouble(0);
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: customcolor, width: 1.0),
              ),
              hintText: AppLocalizations.of(context)!.settingamnthint,
              hintStyle: customTextStyle(Colors.grey, 14, "defaultfont"),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                if (inputamnt != 0.0) {
                  setState(() {
                    viewModel.saveAmntList(widget.id, inputamnt);
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
