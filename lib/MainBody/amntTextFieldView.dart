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
    final inputamnt = AppLocalizations.of(context)!.inputamnt;
    final amntstring = viewModel.amntlist[viewModel.index][widget.id];
    final numberdigit = (viewModel.unitvalue == '¥') ? 0: 2;
    final displayamnt = (amntstring > 0) ? amntstring.toStringAsFixed(numberdigit): inputamnt;
    return TextButton(
      child: Text(displayamnt,
        style: TextStyle(
          color: (displayamnt == inputamnt) ? Colors.grey[400] : Colors.lightBlue,
          fontSize: (displayamnt == inputamnt) ? 14 : 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () =>
      {
        viewModel.clearAmnt(widget.id),
        amntFieldDialog(context),
        setState(() {
          viewModel.getAmntList();
          viewModel.getBalance();
          viewModel.getPercent();
        }),
      },
    );
  }

  Future<void> amntFieldDialog(BuildContext context) async {
    double inputnumber = viewModel.amntlist[viewModel.index][widget.id];
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.settingamnttitle
          ),
          content: TextField(
            onChanged: (value) {
              if (value.toDouble(0) > 0) inputnumber = value.toDouble(0);
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
