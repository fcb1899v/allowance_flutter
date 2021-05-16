import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainViewModel.dart';

class descFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int i;
  descFieldView(this.viewModel, this.i);
  @override
  descFieldViewState createState() => new descFieldViewState(viewModel);
}

class descFieldViewState extends State<descFieldView> {
  final mainViewModel viewModel;
  descFieldViewState(this.viewModel);

  var descController = TextEditingController();

  //データ取得用関数
  void getDescription() async {
    final prefs = await SharedPreferences.getInstance();
    viewModel.desclist[widget.i] = prefs.getString("desckey${widget.i + 1}") ?? "";
    descController = TextEditingController.fromValue(
        TextEditingValue(text: viewModel.desclist[widget.i],
            selection: TextSelection.collapsed(offset: viewModel.desclist[widget.i].length)
        )
    );
    // print("getAmount");
  }

  //データの初期化
  @override
  void initState() {
    super.initState();
    setState(() {
      getDescription();
    });
  }

  //テキストフィールドの表示
  Widget build(BuildContext context) {
    return TextField(
      controller: descController,
      style: TextStyle(
        color: Colors.lightBlue,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        hintText: "Enter",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        border: InputBorder.none,
      ),
      maxLines: 1,
      onChanged: (text) {
        print("Description : $text");
        if (text != null) {
          viewModel.saveDesc(text, widget.i);
        } else {
          viewModel.saveDesc("", widget.i);
        }
        getDescription();
      },
      onTap: (){
        viewModel.saveDesc("", widget.i);
        descController.clear();
      },
    );
  }
}
