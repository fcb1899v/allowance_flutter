import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'mainViewModel.dart';
import '../SpendAllowance.dart';

class balanceView extends StatefulWidget{
  final mainViewModel viewModel;
  final String allowance;
  balanceView(this.viewModel, this.allowance);
  @override
  balanceViewState createState() => new balanceViewState(viewModel);
}

class balanceViewState extends State<balanceView> {

  final mainViewModel viewModel;
  balanceViewState(this.viewModel);

  //データの初期化
  @override
  void initState() {
    super.initState();
    setState(() {
      viewModel.getAmntList();
    });
  }

  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Balance  ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Pacifico',
                ),
              ),
              Text(widget.allowance.toBalance(viewModel.amntlist).toBalancePrice(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: MediaQuery.of(context).size.width - 60,
            lineHeight: 10.0,
            linearStrokeCap: LinearStrokeCap.butt,
            percent: widget.allowance.toPercent(viewModel.amntlist),
            animation: true,
            animationDuration: 2000,
            backgroundColor: Colors.white,
            progressColor: Colors.lightBlue,
          ),
        ]
    );
  }
}

