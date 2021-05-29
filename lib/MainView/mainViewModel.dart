import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/strings.dart';
import '../extension.dart';
import 'dart:async';

class mainViewModel extends Model {

  //＜＞で各月の表示を変更、利用開始月:0
  int _index = 0;
  int get index => _index;

  int _maxindex = 0;
  int get maxindex => _maxindex;

  String _startdate = "01/01/2021";
  String get startdate => _startdate;

  String _name = "";
  String get name => _name;

  int _allowance = 500;
  int get allowance => _allowance;

  String _unitvalue = "¥";
  String get unitvalue => _unitvalue;

  String _version = "0.0.0";
  String get version => _version;

  List<int> _counter = List.generate(100, (_) => 3);
  List<int> get counter => _counter;

  List<int> _maxcounter = List.generate(100, (_) => 3);
  List<int> get maxcounter => _maxcounter;

  List<List<String>> _datelist = List.generate(100, (_) =>
    List.generate(3, (_) => "Select date")
  );
  List<List<String>> get datelist => _datelist;

  List<List<String>> _desclist = List.generate(100, (_) =>
    List.generate(3, (_) => "")
  );
  List<List<String>> get desclist => _desclist;

  List<TextEditingController> _desccontroller = List.generate(100, (_) =>
    TextEditingController()
  );
  List<TextEditingController> get desccontroller  => _desccontroller;

  List<List<int>> _amntlist = List.generate(100, (_) =>
    List.generate(3, (_) => 0)
  );
  List<List<int>> get amntlist => _amntlist;

  List<TextEditingController> _amntcontroller = List.generate(100, (_) =>
    TextEditingController()
  );
  List<TextEditingController> get amntcontroller  => _amntcontroller;

  //データの初期化
  void init()
  {
    getName();
    getAllowance();
    getUnit();
    getVersionNumber();
    getStartDate();
    getCurrentIndex();
    getCounter();
    getDateList();
    getDescList();
    getAmntList();
  }

  void dispose() {
  }

  void nextIndex() async{
    if (maxindex < index + 1) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt("maxindexkey", index + 1);
      _maxindex = index + 1;
    }
    _index++;
    print("index: $index, maxindex: $maxindex, ");
    notifyListeners();
  }

  void beforeIndex() {
    if (index > 0) {
      _index--;
      print("index: $index, maxindex: $maxindex, ");
      notifyListeners();
    }
  }

  void getStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    final flag = prefs.getBool("startdateflagkey") ?? false;
    if (flag == false) {
      await prefs.setString("startdatekey",
          DateTime.now().toDateString("01/01/2021")
      );
      await prefs.setBool("startdateflagkey", true);
    }
    _startdate = prefs.getString("startdatekey") ?? "01/01/2021";
    //print("startdate: ${startdate}");
    notifyListeners();
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _index = startdate.toCurrentIndex();
    _maxindex = prefs.getInt("maxindexkey") ?? index;
    if (index > maxindex) _maxindex = index;
    print("index: $index");
    notifyListeners();
  }

  void increaseCounter() async{
    final prefs = await SharedPreferences.getInstance();
    if (_counter[index] == _maxcounter[index]) {
      await prefs.setInt("maxcounterkey$index", counter[index] + 1);
      _datelist[index].add("Select date");
      _desclist[index].add("");
      _amntlist[index].add(0);
      _maxcounter[index]++;
    }
    _counter[index]++;
    print("counter: ${counter[index]}, maxcounter: ${maxcounter[index]}");
    notifyListeners();
  }

  void decreaseCounter() {
    if (_counter[index] > 1) {
      _counter[index]--;
    }
    notifyListeners();
  }

  void getCounter() async{
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      _counter[i] = prefs.getInt("counterkey$i") ?? 3;
      //print("Index : ${index}, getCounter : ${_counter}");
    }
    notifyListeners();
  }

  void saveDateList(int id, DateTime date) async{
    final prefs = await SharedPreferences.getInstance();
    _datelist[index][id] = date.toDateString("");
    prefs.setString("datekey${index}_$id", date.toDateString("Select date"));
    print("index: $index, id: $id, Date : ${date.toDateString("Select date")}");
    notifyListeners();
  }

  void getDateList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int id = 0; id < maxcounter[index]; id++) {
      _datelist[index][id] = prefs.getString("datekey${index}_$id") ?? "Select date";
    }
    notifyListeners();
  }

  void clearDate(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("datekey${index}_$id", "Select date");
    print("clearDate");
    notifyListeners();
  }

  //DatePickerで日付を記録
  Future selectDate(BuildContext context, int id) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startdate.toDisplayDate(index),
      firstDate: DateTime(startdate.toDisplayDate(index).year - 1),
      lastDate: DateTime(startdate.toDisplayDate(index).year + 1),
    );
    if(picked != null) {
      saveDateList(id, picked);
    }
  }

  void saveDescList(int id, String description) async{
    final prefs = await SharedPreferences.getInstance();
    _desclist[index][id] = description;
    prefs.setString("desckey${index}_$id", description);
    print("index: $index, id: $id, saveDescription : $description");
    notifyListeners();
  }

  void getDescList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int id = 0; id < maxcounter[index]; id++) {
      _desclist[index][id] = prefs.getString("desckey${index}_$id") ?? "";
      _desccontroller[id] = TextEditingController.fromValue(
        TextEditingValue(text: _desclist[index][id],
          selection: TextSelection.collapsed(
              offset: _desclist[index][id].length
          ),
        ),
      );
    }
    notifyListeners();
  }

  void clearDesc(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("desckey${index}_$id", "");
    print("clearDesc");
    notifyListeners();
  }

  void saveAmntList(int id, int amount) async{
    final prefs = await SharedPreferences.getInstance();
    _amntlist[index][id] = amount;
    prefs.setInt("amntkey${index}_$id", amount);
    //print("id: $id, saveAmount: $amount");
    notifyListeners();
  }

  void getAmntList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int id = 0; id < maxcounter[index]; id++) {
      _amntlist[index][id] = prefs.getInt("amntkey${index}_$id") ?? 0;
      _amntcontroller[id] = TextEditingController.fromValue(
        TextEditingValue(text: _amntlist[index][id].toNumberString(),
          selection: TextSelection.collapsed(
              offset: _amntlist[index][id].toNumberString().length
          ),
        ),
      );
    }
    notifyListeners();
  }

  void clearAmnt(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("amntkey${index}_$id", 0);
    print("clearAmnt");
    notifyListeners();
  }

  void refresh() {
    //print("Refresh");
    notifyListeners();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("namekey") ?? "Not set";
    //print("getName : ${name}");
    notifyListeners();
  }

  void saveName(String? stringname) async {
    final prefs = await SharedPreferences.getInstance();
    if (isNotBlank(stringname)) {
      await prefs.setString("namekey", stringname!);
    }
    //print("saveName : ${name}");
    notifyListeners();
  }

  void getAllowance() async {
    final prefs = await SharedPreferences.getInstance();
    _allowance = prefs.getInt("allowancekey") ?? 500;
    //print("getAllowance : ${allowance}");
    notifyListeners();
  }

  void saveAllowance(int? intallowance) async {
    final prefs = await SharedPreferences.getInstance();
    if ((intallowance ?? 0) != 0) {
      await prefs.setInt("allowancekey", intallowance!);
    }
    //print("saveAllowance : ${allowance}");
    notifyListeners();
  }

  void getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    _unitvalue = prefs.getString("unitkey") ?? "¥";
    //print("getUnit : ${unitvalue}");
    notifyListeners();
  }

  void saveUnit(String? unit) async {
    final prefs = await SharedPreferences.getInstance();
    if (isNotBlank(unit)) {
      await prefs.setString("unitkey", unit!);
    }
    //print("saveUnit : ${unitvalue}");
    notifyListeners();
  }

  void getVersionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    //print("getVersion : ${version}");
    notifyListeners();
  }
}
