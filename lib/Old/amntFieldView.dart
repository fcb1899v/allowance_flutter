import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../MainView/extension.dart';
import '../MainView/mainViewModel.dart';

class amntFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  amntFieldView(this.viewModel, this.id);
  @override
  amntFieldViewState createState() => new amntFieldViewState(viewModel);
}

class amntFieldViewState extends State<amntFieldView> {
  final mainViewModel viewModel;
  amntFieldViewState(this.viewModel);

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: TextEditingController(),
      style: TextStyle(
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.enter,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        border: InputBorder.none
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      onChanged: (text) {
        print("Amount : $text");
        if (text.toInt(0) > 0) {
          viewModel.saveAmntList(widget.id, text.toDouble(0));
        }
        viewModel.getAmntList();
      },
      onTap: () {
        viewModel.saveAmntList(widget.id, 0);
        viewModel.getAmntList();
        //viewModel.amntcontroller.clear();
      },
    );
  }
}
