import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

class deleteButtonView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  deleteButtonView(this.viewModel, this.id);
  @override
  deleteButtonViewState createState() => new deleteButtonViewState(viewModel);
}

class deleteButtonViewState extends State<deleteButtonView> {

  final mainViewModel viewModel;

  deleteButtonViewState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    int i = viewModel.index;
    String description = viewModel.spendlist[i][widget.id]["desc"];
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    Color? customcolor = (isBlank(description)) ? Colors.grey:
             (amount < 0.0) ? Colors.lightBlue : Colors.pinkAccent;
    if (widget.id != viewModel.counter[i] - 1) {
      return PopupMenuButton(
        icon: customIcon(Icons.more_vert, customcolor, 20),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: '',
              child: Row(
                children: <Widget>[
                  customIcon(CupertinoIcons.delete, customcolor, 20),
                  Text(" ${AppLocalizations.of(context)!.delete}",
                    style: customTextStyle(customcolor, 16, "defaultfont",)
                  ),
                ],
              ),
            ),
          ];
        },
        onSelected: (_) {
          setState(() {
            viewModel.deleteSpend(widget.id);
          });
        },
      );
    } else {
      return Text("", style: customTextStyle(Colors.grey, 16, "defaultfont"));
    }
  }
}