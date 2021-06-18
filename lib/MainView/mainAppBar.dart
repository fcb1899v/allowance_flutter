import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../extension.dart';
import 'mainViewModel.dart';


class mainAppBar extends StatefulWidget implements PreferredSizeWidget{
  final mainViewModel viewModel;
  mainAppBar(this.viewModel);
  @override
  mainAppBarState createState() => new mainAppBarState(viewModel);
  @override
  final Size preferredSize = AppBar().preferredSize;
}

class mainAppBarState extends State<mainAppBar> {

  final mainViewModel viewModel;
  mainAppBarState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Text(viewModel.startdate.toDate().displayMonthYear(viewModel.index),
        style: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontFamily: 'Pacifico',
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.deepPurpleAccent,
              Theme.of(context).primaryColor
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