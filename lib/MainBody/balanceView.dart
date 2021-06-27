import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';
import '/MainView/extension.dart';

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
    final lang = Localizations.localeOf(context).languageCode;
    final customfont = (lang == "ja") ? "defaultfont": 'enAccent';
    final customsize = (lang == "ja") ? 24.0: 32.0;
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
                  Text("${AppLocalizations.of(context)!.balance}",
                    style: customShadowTextStyle(Colors.white, customsize, customfont),
                  ),
                  Text(" [", style: customShadowTextStyle(Colors.white, 24, null),),
                  DropdownButton <String>(
                    value: viewModel.unitvalue,
                    dropdownColor: Colors.lightBlue,
                    style: customShadowTextStyle(Colors.white, 24, null),
                    icon: Icon(CupertinoIcons.minus, size: 0.1),
                    underline: SizedBox(),
                    onChanged: (value) {
                      viewModel.saveUnit(value);
                      setState(() {
                        viewModel.saveUnit(value);
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
                  Text("] ", style: customShadowTextStyle(Colors.white, 24, null),),
                  Text("${viewModel.balancelist[viewModel.index].stringMoney(viewModel.unitvalue)}",
                    style: customShadowTextStyle(Colors.white, 32, "defaultfont"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                width: MediaQuery.of(context).size.width * 0.8,
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

