import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';


class monthPlusMinus extends StatefulWidget{
  final mainViewModel viewModel;
  monthPlusMinus(this.viewModel);
  @override
  monthPlusMinusState createState() => new monthPlusMinusState(viewModel);
}

class monthPlusMinusState extends State<monthPlusMinus> {
  final mainViewModel viewModel;
  monthPlusMinusState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Spacer(),
        Container(
          width: 30,
          height: 30,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: (viewModel.index > 0) ?
              Colors.lightBlue: Colors.grey,
              onPressed: () { // Startボタンタップ時の処理
                if (viewModel.index > 0) {
                  setState(() {
                    viewModel.beforeIndex();
                  });
                }
              },
              child: Icon(CupertinoIcons.back),
              heroTag: "herominus",
            ),
          ),
        ),
        Spacer(),
        Text(viewModel.startdate.displayMonthYear(viewModel.index),
          style: customShadowTextStyle(Colors.white, 24, 'enAccent',),
        ),
        Spacer(),
        Container(
          width: 30,
          height: 30,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () { // Startボタンタップ時の処理
                setState(() {
                  viewModel.nextIndex();
                });
              },
              child: Icon(CupertinoIcons.forward),
              heroTag: "heroplus",
            ),
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }
}