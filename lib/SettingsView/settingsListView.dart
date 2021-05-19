import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:allowance_app/MainView/mainViewModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SpendAllowance.dart';

class settingsListView extends StatefulWidget{
  final mainViewModel viewModel;
  settingsListView(this.viewModel);
  @override
  settingsListViewState createState() => new settingsListViewState(viewModel);
}

class settingsListViewState extends State<settingsListView> {

  final mainViewModel viewModel;
  settingsListViewState(this.viewModel);

  DateTime? date = null;
  String datestring = "Not set";

  //データ保存用関数
  saveDate(DateTime? date) async {
    final prefs = await SharedPreferences.getInstance();
    if (date != null) {
      await prefs.setString("startdatekey", date.toDateString("Not set"));
      // print("saveDate");
    }
  }

  //データ取得用関数
  getDate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      datestring = prefs.getString("startdatekey") ?? "Not set";
    });
    // print("getDate");
  }

  //DatePickerで日付を記録
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) setState(() =>
    {
      date = picked,
      saveDate(date!),
      getDate(),
      // print("datepicker");
    });
  }

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

  String inputallowance = "";

  Future<void> allowanceFieldDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Settings your monthly allowance"),
          content: TextField(
            onChanged: (value) {
              if (value.toInt(0) > 0) {
                inputallowance = value;
              }
            },
            controller: TextEditingController(),
            decoration: InputDecoration(hintText: "Enter your monthly allowance"),
            keyboardType: TextInputType.number,
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
                if (inputallowance.toInt(0) > 0) {
                  viewModel.saveAllowance(inputallowance.toInt(0));
                }
                setState(() {
                  viewModel.getAllowance();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> unitDropDownListDialog(BuildContext context) async {
    String selectunit = viewModel.unitvalue;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Settings your currency unit"),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  DropdownButton <String>(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    value: selectunit,
                    onChanged: (String? newValue) {
                      if (selectunit != null || selectunit != "") {
                        selectunit = newValue!;
                      }
                    },
                    items: <String>["¥", "\$", "€", "£",]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              );
            },
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
                if (selectunit != null || selectunit != "") {
                  viewModel.saveUnit(selectunit);
                }
                setState(() {
                  viewModel.getUnit();
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
    getDate();
    viewModel.getAllowance();
  }

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
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
        ),
        SettingsSection(
          title: '',
          tiles: [
            SettingsTile(
              title: 'Start date',
              subtitle: datestring,
              leading: Icon(Icons.calendar_today_outlined),
              onPressed: (BuildContext context) {
                selectDate(context);
              },
            ),
          ],
        ),
        SettingsSection(
          title: '',
          tiles: [
            SettingsTile(
              title: 'Monthly allowance',
              subtitle: "${viewModel.unitvalue} ${viewModel.allowance.toString()}",
              leading: Icon(Icons.monetization_on_outlined),
              onPressed: (BuildContext context) {
                allowanceFieldDialog(context);
              },
            ),
          ],
        ),
        SettingsSection(
          title: '',
          tiles: [
            SettingsTile(
              title: 'Currency unit',
              subtitle: "${viewModel.unitvalue}",
              leading: Icon(Icons.monetization_on_outlined),
              onPressed: (BuildContext context) {
                unitDropDownListDialog(context);
              },
            ),
          ],
        )
      ],
    ); 
  }
}