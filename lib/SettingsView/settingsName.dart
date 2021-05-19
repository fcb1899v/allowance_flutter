import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:allowance_app/MainView/mainViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SpendAllowance.dart';

class settingsName extends StatefulWidget{
  final mainViewModel viewModel;
  settingsName(this.viewModel);
  @override
  settingsNameState createState() => new settingsNameState(viewModel);
}

class settingsNameState extends State<settingsName> {

  final mainViewModel viewModel;
  settingsNameState(this.viewModel);

  String inputname = "";

  Future<void> nameFieldDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Settings your name"),
          content: TextField(
            onChanged: (value) {
              if (value != null || value != "") {
                inputname = value;
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(hintText: "Enter your name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text("OK",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                if (inputname != null || inputname != "") {
                  viewModel.saveName(inputname);
                }
                setState(() {
                  viewModel.getName();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //データの初期化
  @override
  void initState() {
    super.initState();
    viewModel.getName();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: '',
      tiles: [
        SettingsTile(
          title: 'Name',
          subtitle: viewModel.name,
          leading: Icon(Icons.face),
          onPressed: (BuildContext context) {
            nameFieldDialog(context);
          },
        ),
      ],
    );
  }
}