import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'mainViewModel.dart';


class drawerView extends StatefulWidget{
  final mainViewModel viewModel;
  drawerView(this.viewModel);
  @override
  drawerViewState createState() => new drawerViewState(viewModel);
}

class drawerViewState extends State<drawerView> {
  final mainViewModel viewModel;
  drawerViewState(this.viewModel);

  @override
  void initState() {
    super.initState();
    setState(() {
      viewModel.getName();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  child: TextButton(
                    child: Text((viewModel.name == "") ? "Allowance":
                      "${viewModel.name}'s Allowance",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                      textAlign: TextAlign.start,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/SettingsView");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}