import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'mainViewModel.dart';

class mainBottomNavi extends StatefulWidget {
  final mainViewModel viewModel;
  mainBottomNavi(this.viewModel);
  @override
  mainBottomNaviState createState() => new mainBottomNaviState(viewModel);
}

class mainBottomNaviState extends State<mainBottomNavi> {
  final mainViewModel viewModel;
  mainBottomNaviState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightBlue,
      unselectedItemColor: Colors.grey[400],
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.calendar),
          label: AppLocalizations.of(context)!.list,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize_sharp),
          label: AppLocalizations.of(context)!.summary,
        ),
      ],
      onTap: (int index) {
        setState(() {
          viewModel.changeSelectFlag();
        });
      },
      currentIndex: (viewModel.selectflag) ? 0: 1,
    );
  }
}