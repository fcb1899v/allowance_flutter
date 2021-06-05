import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MainView/mainViewModel.dart';

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
    final datestring = viewModel.datelist[viewModel.index][widget.id];
    return InkWell(
      onTap: () => {
        if (viewModel.datelist[viewModel.index][widget.id] != 0) {
          viewModel.selectDate(context, widget.id),
          setState(() {
            viewModel.getDateList();
          }),
        },
      },
      child: SizedBox(
        child: Container(
          width: double.infinity,
          child: Text((datestring < 1 || datestring > 31 || datestring == null) ? "-": "$datestring",
            style: TextStyle(
              color: (datestring == 0) ? Colors.grey[400]: Colors.lightBlue,
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
}
