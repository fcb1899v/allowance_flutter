import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import '../MainView/mainViewModel.dart';

class segmentMenu extends StatefulWidget {
  final mainViewModel viewModel;
  segmentMenu(this.viewModel);
  @override
  _segmentMenuState createState() => _segmentMenuState(viewModel);
}

class _segmentMenuState extends State<segmentMenu> {
  final mainViewModel viewModel;
  _segmentMenuState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: CupertinoSlidingSegmentedControl(
          groupValue: viewModel.lyflag,
          thumbColor: Colors.lightBlue,
          backgroundColor: Colors.white,
          padding: EdgeInsets.all(2),
          children: <bool, Widget>{
            true: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Monthly',
                style: TextStyle(
                  color: (viewModel.lyflag) ? Colors.white: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            false: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Yearly',
                style: TextStyle(
                  color: (viewModel.lyflag) ? Colors.lightBlue: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          },
          onValueChanged: (value) {
            setState(() {
              viewModel.changeLyFlag();
            });
          }
      )
    );
  }
}