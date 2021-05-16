import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:allowance_app/main.dart';

class mainAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  final Size preferredSize = AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu,
        color: Colors.white,
      ),
      title: Text(MyApp.title,
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