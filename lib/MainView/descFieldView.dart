import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mainViewModel.dart';

class descFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  descFieldView(this.viewModel, this.id);
  @override
  descFieldViewState createState() => new descFieldViewState(viewModel);
}

class descFieldViewState extends State<descFieldView> {
  final mainViewModel viewModel;
  descFieldViewState(this.viewModel);

  //テキストフィールドの表示
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      controller: viewModel.desccontroller[widget.id],
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
        border: InputBorder.none,
      ),
      maxLines: 1,
      onChanged: (text) {
        if (text.isNotEmpty) {
          viewModel.saveDescList(widget.id, text);
          viewModel.getDescList();
          print("Description : $text");
        }
      },
      onTap: () {
        viewModel.saveDescList(widget.id, "");
        viewModel.getDescList();
        viewModel.desccontroller[widget.id].clear();
      },
    );
  }
}
