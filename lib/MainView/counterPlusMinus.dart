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
          backgroundColor: (viewModel.index > 0) ? Colors.lightBlue: Colors.grey,
          onPressed: () { // Startボタンタップ時の処理
            if (viewModel.index > 0) {
              setState(() {
                viewModel.decreaseIndex();
                viewModel.getCounter();
                viewModel.getDescList();
                viewModel.getAmntList();
                viewModel.getAllowance();
              });
            }
          },
          child: Icon(CupertinoIcons.back),
          tooltip: 'Decrease',
          heroTag: "hero4",
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: (viewModel.counter > 1) ? Colors.lightBlue: Colors.grey,
          onPressed: () { // Startボタンタップ時の処理
            viewModel.decreaseCounter();
          },
          child: Icon(CupertinoIcons.minus),
          tooltip: 'Decrease',
          heroTag: "hero3",
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: (viewModel.counter < 10) ? Colors.lightBlue: Colors.grey,
          onPressed: () { // Stopボタンタップ時の処理
            viewModel.increaseCounter();
          },
          child: Icon(CupertinoIcons.add),
          tooltip: 'Increase',
          heroTag: "hero2",
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: Colors.lightBlue,
          onPressed: () { // Startボタンタップ時の処理
            setState(() {
              viewModel.increaseIndex();
              viewModel.getCounter();
              viewModel.getDescList();
              viewModel.getAmntList();
              viewModel.getAllowance();
            });
          },
          child: Icon(CupertinoIcons.forward),
          tooltip: 'Increase',
          heroTag: "hero1",
        ),
        Spacer(),
      ],
    );
  }
}