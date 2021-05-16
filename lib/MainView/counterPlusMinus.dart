import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainViewModel.dart';

class counterPlusMinus extends StatefulWidget{
  final mainViewModel viewModel;
  counterPlusMinus(this.viewModel);
  @override
  counterPlusMinusState createState() => new counterPlusMinusState(viewModel);
}

class counterPlusMinusState extends State<counterPlusMinus> {
  final mainViewModel viewModel;
  counterPlusMinusState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () { // Startボタンタップ時の処理
            viewModel.refresh();
          },
          child: Icon(CupertinoIcons.refresh),
          tooltip: 'Decrease',
        ),
        Spacer(),
        // FloatingActionButton(
        //   backgroundColor: Colors.lightBlue,
        //   onPressed: () { // Startボタンタップ時の処理
        //     viewModel.reflesh();
        //   },
        //   child: Icon(CupertinoIcons.trash),
        //   tooltip: 'Decrease',
        // ),
        // Spacer(),
        FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () { // Startボタンタップ時の処理
            viewModel.decreaseCounter();
          },
          child: Icon(CupertinoIcons.minus),
          tooltip: 'Decrease',
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () { // Stopボタンタップ時の処理
            viewModel.increaseCounter();
          },
          child: Icon(CupertinoIcons.add),
          tooltip: 'Increase',
        ),
        Spacer(),
      ],
    );
  }
}