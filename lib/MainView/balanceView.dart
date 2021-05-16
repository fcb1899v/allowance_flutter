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
      viewModel.getUnit();
      viewModel.getAmntList();
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: FittedBox(
        child: Container(
          padding: EdgeInsets.only(left: 50, right: 50,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Balance  ',
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[Shadow(
                        offset: Offset(2.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.white,
                      )],
                      fontFamily: 'Pacifico',
                    ),
                  ),
                  DropdownButton <String>(
                    value: viewModel.unitvalue,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[Shadow(
                        offset: Offset(2.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.white,
                      )],
                    ),
                    icon:  Icon(CupertinoIcons.minus, size: 0.1),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      viewModel.saveUnit(newValue!);
                      setState(() {
                        viewModel.getUnit();
                      });
                    },
                    items: <String>["¥", "\$", "€", "£",]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Text(widget.allowance.toBalance(viewModel.amntlist).toString(),
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[Shadow(
                        offset: Offset(2.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.white,
                      )],
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
            ],
          ),
        ),
      ),
    );
  }
}

