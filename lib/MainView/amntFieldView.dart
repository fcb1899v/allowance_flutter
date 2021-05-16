import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainViewModel.dart';
import '../SpendAllowance.dart';

class amntFieldView extends StatefulWidget{
  final mainViewModel viewModel;
  final int i;
  amntFieldView(this.viewModel, this.i);
  @override
  amntFieldViewState createState() => new amntFieldViewState(viewModel);
}

class amntFieldViewState extends State<amntFieldView> {
  final mainViewModel viewModel;
  amntFieldViewState(this.viewModel);

  var amntcontroller = TextEditingController();

  //データ取得用関数
  void getAmount() async {
    final prefs = await SharedPreferences.getInstance();
    viewModel.amntlist[widget.i] = prefs.getInt("amntkey${widget.i + 1}") ?? 0;
    amntcontroller = TextEditingController.fromValue(
        TextEditingValue(text: viewModel.amntlist[widget.i].toPrice(),
            selection: TextSelection.collapsed(offset: viewModel.amntlist[widget.i].toString().length)
        )
    );
    // print("getAmount");
  }

  //データの初期化
  @override
  void initState() {
    super.initState();
    setState(() {
      viewModel.getCounter();
      getAmount();
    });
  }

  //金額を入力および表示するテキストフィールド
  Widget build(BuildContext context) {
    return TextField(
      controller: amntcontroller,
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
        border: InputBorder.none
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      onChanged: (text) {
        print("Amount : $text");
        if (text != "" || text != null || text.toInt(0) != null || text.toInt(0) != 0) {
          viewModel.saveAmnt(text.toInt(0), widget.i);
        } else {
          viewModel.saveAmnt(0, widget.i);
        }
        getAmount();
      },
      onTap: () {
        viewModel.saveAmnt(0, widget.i);
        getAmount();
      },
    );
  }
}
