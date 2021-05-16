import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class datePickerView extends StatefulWidget{
  final int i;
  datePickerView(this.i);
  @override
  datePickerViewState createState() => new datePickerViewState();
}

class datePickerViewState extends State<datePickerView> {

  DateTime date = DateTime.now();
  String datestring = "Select";

  //データ保存用関数
  saveDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final datestring = "${date.month}/${date.day}/${date.year}";
    await prefs.setString("datekey${widget.i + 1}", datestring);
    // print("saveDate");
  }

  //データ取得用関数
  getDate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      datestring = prefs.getString("datekey${widget.i + 1}") ?? "Select";
    });
    // print("getDate");
  }

  clearDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("datekey${widget.i + 1}", "Select");
    setState(() {
      datestring = "Select";
    });
    // print("clearDate");
  }

  //DatePickerで日付を記録
  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
    );
    if(picked != null) setState(() => {
      date = picked,
      datestring = "${date.month}/${date.day}/${date.year}",
      saveDate(date)
      // print("datepicker");
    });
  }

  //データの初期化
  @override
  void initState() {
    super.initState();
    getDate();
  }

  //DatePickerが表示されるボタン＆選択した日付の表示
  Widget build(BuildContext context) {
    return TextButton(
        child: Text(datestring,
          style: TextStyle(
            color: (datestring == "Select") ? Colors.grey: Colors.lightBlue,
            fontSize: (datestring == "Select") ? 14: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => {
          clearDate(),
          selectDate(context),
        },
    );
  }
}
