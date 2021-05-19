import 'package:allowance_app/MainView/allowance.dart';
import 'package:allowance_app/MainView/mainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:allowance_app/main.dart';

class settingsAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize = AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllowancePage(mainViewModel())
            ),
          );
        },
      ),
      title: Text("Settings",
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Pacifico',
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Colors.deepPurpleAccent,
                Theme
                    .of(context)
                    .primaryColor
              ]
          ),
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
          child: Container(
            color: Colors.white,
            height: 4.0,
          ),
          preferredSize: Size.fromHeight(4.0)
      ),
    );
  }
}