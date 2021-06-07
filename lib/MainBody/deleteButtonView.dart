import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';

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
    String description = viewModel.desclist[i][widget.id];
    double amount = viewModel.amntlist[i][widget.id];
    Color? customcolor = (isBlank(description)) ? Colors.grey : (amount < 0.0)
        ? Colors.lightBlue
        : Colors.pinkAccent;
    if (widget.id != viewModel.counter[i] - 1) {
      return PopupMenuButton(
        icon: Icon(Icons.more_vert,
          color: customcolor,
          size: 20,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              value: '',
              child: Row(
                children: <Widget>[
                  Icon(CupertinoIcons.delete,
                    color: customcolor,
                    size: 20,
                  ),
                  Text(" ${AppLocalizations.of(context)!.delete}",
                      style: TextStyle(
                        color: customcolor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "defaultfont",
                      )
                  ),
                ],
              ),
            ),
          ];
        },
        onSelected: (_) {
          setState(() {
            print("id: ${widget.id}");
            viewModel.deleteList(widget.id);
            viewModel.decreaseCounter();
            viewModel.init();
          });
        },
      );
    } else {
      return Text("",);
    }
  }
}