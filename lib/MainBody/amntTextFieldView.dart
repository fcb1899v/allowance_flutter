import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

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
    double amount = viewModel.amntlist[i][widget.id];
    return InkWell(
      onTap: () => {
        if (widget.id != viewModel.counter[i] - 1) amntFieldDialog(context)
      },
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((amount == 0.0) ? "-": amount.stringAmount(viewModel.unitvalue),
            style: TextStyle(
              color: (amount == 0.0) ? Colors.grey[400]: Colors.lightBlue,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Future<void> amntFieldDialog(BuildContext context) async {
    int i = viewModel.index;
    double inputnumber = viewModel.amntlist[i][widget.id];
    double plusminus = (inputnumber < 0) ? -1.0: 1.0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.amnt,
            style: TextStyle(fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              inputnumber = plusminus * value.toDouble(0);
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingamnthint,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
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
                Navigator.pop(context);
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
                viewModel.saveAmntList(widget.id, inputnumber);
                viewModel.saveBalance();
                viewModel.savePercent();
                setState(() {
                  viewModel.getAmntList();
                  viewModel.getBalance();
                  viewModel.getPercent();
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
