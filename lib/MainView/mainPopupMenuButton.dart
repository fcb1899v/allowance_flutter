import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'commonWidget.dart';
import 'mainViewModel.dart';

class mainPopupMenuButton extends StatefulWidget{
  final mainViewModel viewModel;
  mainPopupMenuButton(this.viewModel);
  @override
  mainPopupMenuButtonState createState() => new mainPopupMenuButtonState(viewModel);
}

class mainPopupMenuButtonState extends State<mainPopupMenuButton> {

  final mainViewModel viewModel;
  mainPopupMenuButtonState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var popuplist = [(viewModel.isLogin) ?
      AppLocalizations.of(context)!.logout:
      AppLocalizations.of(context)!.login,
    ];
    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Colors.white,),
      initialValue: (viewModel.isLogin) ?
        AppLocalizations.of(context)!.logout:
        AppLocalizations.of(context)!.login,
      onSelected: (String value) async {
        if (viewModel.isLogin) {
          FirebaseAuth.instance.signOut();
          viewModel.stateLogout();
          print("Logout: ${viewModel.isLogin}");
          await new Future.delayed(new Duration(seconds: 2));
        }
        pushPage(context, "/l");
      },
      itemBuilder: (context) {
        return popuplist.map((String value) {
          return PopupMenuItem(
            child: ListTile(
              leading:Icon(CupertinoIcons.person_circle, color: Colors.lightBlue,),
              title:Text(value, style: customTextStyle(Colors.lightBlue, 16, "defaultfont"),),
            ),
            value: value,
          );
        }).toList();
      }
    );
  }
}

