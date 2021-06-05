import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MainView/mainViewModel.dart';

class deleteButton extends StatefulWidget{
  final mainViewModel viewModel;
  deleteButton(this.viewModel);
  @override
  deleteButtonState createState() => new deleteButtonState(viewModel);
}

class deleteButtonState extends State<deleteButton> {

  final mainViewModel viewModel;
  deleteButtonState(this.viewModel);

  //TextFieldが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    final id = viewModel.counter[viewModel.index] - 1;
    return FloatingActionButton(
      backgroundColor: (id > 0) ? Colors.lightBlue : Colors.grey,
      onPressed: () { // Startボタンタップ時の処理
        setState(() {
          if (id > 0) {
            viewModel.saveDateList(id - 1, 0);
            viewModel.saveDescList(id - 1, "");
            viewModel.saveAmntList(id - 1, 0.0);
            viewModel.decreaseCounter();
            viewModel.init();
          }
        });
      },
      child: Icon(CupertinoIcons.delete),
      tooltip: 'delete',
    );
  }
}
