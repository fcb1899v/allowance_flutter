import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

class yearPlusMinus extends StatefulWidget{
  final mainViewModel viewModel;
  yearPlusMinus(this.viewModel);
  @override
  yearPlusMinusState createState() => new yearPlusMinusState(viewModel);
}

class yearPlusMinusState extends State<yearPlusMinus> {
  final mainViewModel viewModel;
  yearPlusMinusState(this.viewModel);

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
              backgroundColor: (viewModel.yearindex > 0) ?
                Colors.lightBlue: Colors.grey,
              onPressed: () {
                setState(() {
                  viewModel.decreaseYearIndex();
                });
              },
              child: Icon(CupertinoIcons.back),
              heroTag: "herominus2",
            ),
          ),
        ),
        Spacer(),
        Text("${viewModel.startdate.toYear() + viewModel.yearindex}",
          style: customShadowTextStyle(Colors.white, 24, 'enAccent'),
        ),
        Spacer(),
        Container(
          width: 30,
          height: 30,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: (viewModel.yearindex < 9) ?
                Colors.lightBlue: Colors.grey,
              onPressed: () {
                setState((){
                  viewModel.increaseYearIndex();
                });
              },
              child: Icon(CupertinoIcons.forward),
              heroTag: "heroplus2",
            ),
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }
}