import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mainViewModel.dart';

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
    final selectdate = AppLocalizations.of(context)!.selectdate;
    final datestring = viewModel.datelist[viewModel.index][widget.id];
    final displaydate = (datestring == "Select date") ? selectdate: datestring;
    return TextButton(
      child: Text(displaydate,
        style: TextStyle(
          color: (displaydate == selectdate) ? Colors.grey[400]: Colors.lightBlue,
          fontSize: (displaydate == selectdate) ? 14: 16,
          fontWeight: FontWeight.bold,
        ),
        maxLines: 1,
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () => {
        viewModel.clearDate(widget.id),
        viewModel.selectDate(context, widget.id),
        setState(() {
          viewModel.getDateList();
        }),
      },
    );
  }
}
