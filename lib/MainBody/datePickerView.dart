import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class datePickerView extends StatefulWidget{
  final mainViewModel viewModel;
  final int id;
  datePickerView(this.viewModel, this.id);
  @override
  datePickerViewState createState() => new datePickerViewState(viewModel);
}

class datePickerViewState extends State<datePickerView> {

  final mainViewModel viewModel;
  datePickerViewState(this.viewModel);

  //DatePickerが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    int i = viewModel.index;
    int intday = viewModel.spendlist[i][widget.id]["date"];
    String description = viewModel.spendlist[i][widget.id]["desc"];
    double amount = viewModel.spendlist[i][widget.id]["amnt"];
    Color? customcolor = (description == "" && amount == 0.0) ? Colors.grey:
                           (amount < 0.0) ? Colors.lightBlue: Colors.pinkAccent;
    return InkWell(
      onTap: () => {
        if (widget.id != viewModel.counter[i] - 1 || (description != "" && amount != 0.0)) {
          viewModel.selectDate(context, widget.id),
        },
      },
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((intday > 0 && intday < 32) ?
                   viewModel.startdate.displayMonthDay(viewModel.index, intday): "-",
            style: customTextStyle(customcolor, 14, "defaultfont"),
            textAlign: TextAlign.right,
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
