import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../MainView/mainViewModel.dart';
import '../MainView/extension.dart';

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
              tooltip: 'Decrease',
              heroTag: "hero12",
            ),
          ),
        ),
        Spacer(),
        Text("${viewModel.startdate.toYear() + viewModel.yearindex}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 1.0,
                color: Colors.lightBlue,
              ),
            ],
            fontFamily: 'enAccent',
          ),
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
              tooltip: 'Increase',
              heroTag: "hero11",
            ),
          ),
        ),
        Spacer(),
        Spacer(),
      ],
    );
  }
}