import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../MainView/mainViewModel.dart';

class balanceView extends StatefulWidget{
  final mainViewModel viewModel;
  balanceView(this.viewModel);
  @override
  balanceViewState createState() => new balanceViewState(viewModel);
}

class balanceViewState extends State<balanceView> {

  final mainViewModel viewModel;
  balanceViewState(this.viewModel);

  Widget build(BuildContext context) {
    var lang = Localizations.localeOf(context).languageCode;
    final numberdigit = (viewModel.unitvalue == '¥') ? 0: 2;
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
                  Text(AppLocalizations.of(context)!.balance,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 1.0,
                          color: Colors.lightBlue,
                        ),
                      ],
                      fontFamily: (lang == "ja") ? 'jaAccent': 'enAccent',
                    ),
                  ),
                  DropdownButton <String>(
                    value: viewModel.unitvalue,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 1.0,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                    icon: Icon(CupertinoIcons.minus, size: 0.1),
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
                  Text(viewModel.balancelist[viewModel.index].toStringAsFixed(numberdigit),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 1.0,
                          color: Colors.lightBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                width: MediaQuery.of(context).size.width - 60,
                lineHeight: 10.0,
                linearStrokeCap: LinearStrokeCap.roundAll,
                percent: viewModel.percentlist[viewModel.index],
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

