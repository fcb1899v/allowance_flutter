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
          backgroundColor: (viewModel.index > 0) ?
            Colors.lightBlue: Colors.grey,
          onPressed: () { // Startボタンタップ時の処理
            if (viewModel.index > 0) {
              setState(() {
                viewModel.beforeIndex();
                viewModel.getCounter();
                viewModel.getDateList();
                viewModel.getDescList();
                viewModel.getAmntList();
              });
            }
          },
          child: Icon(CupertinoIcons.back),
          tooltip: 'Decrease',
          heroTag: "hero4",
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: (viewModel.counter[viewModel.index] > 1) ?
            Colors.lightBlue: Colors.grey,
          onPressed: () {
            setState(() {
              viewModel.decreaseCounter();
            });
          },
          child: Icon(CupertinoIcons.minus),
          tooltip: 'Decrease',
          heroTag: "hero3",
        ),
        Spacer(),
        FloatingActionButton(
          backgroundColor: (viewModel.counter[viewModel.index] < 10) ?
            Colors.lightBlue: Colors.grey,
          onPressed: () {
            setState((){
              viewModel.increaseCounter();
            });
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
              viewModel.nextIndex();
              viewModel.getCounter();
              viewModel.getDateList();
              viewModel.getDescList();
              viewModel.getAmntList();
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