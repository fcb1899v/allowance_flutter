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
    double amount = viewModel.amntlist[viewModel.index][widget.id];
    return InkWell(
      onTap: () => amntFieldDialog(context),
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((amount == 0.0) ? "-": amount.stringAmount(viewModel.unitvalue),
            style: TextStyle(
              color: (amount == 0.0) ? Colors.grey[400]: Colors.lightBlue,
              fontSize: 16,
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
    double inputnumber = viewModel.amntlist[viewModel.index][widget.id];
    double plusminus = (inputnumber < 0) ? -1.0: 1.0;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.settingamnttitle
          ),
          content: TextField(
            onChanged: (value) {
              inputnumber = plusminus * value.toDouble(0);
              viewModel.saveAmntList(widget.id, inputnumber);
            },
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.settingamnthint,
              hintStyle: TextStyle(color: Colors.grey[400]),
            ),
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
                setState(() {
                  viewModel.saveAmntList(widget.id, 0.0);
                  viewModel.saveBalance();
                  viewModel.savePercent();
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
