import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/strings.dart';
import 'extension.dart';
import 'dart:async';

class mainViewModel extends Model {

  bool _selectflag = true;
  bool get selectflag => _selectflag;

  bool _lyflag = true;
  bool get lyflag => _lyflag;

  int _index = 0;
  int get index => _index;

  int _maxindex = 0;
  int get maxindex => _maxindex;

  int _yearindex = 0;
  int get yearindex => _yearindex;

  String _startdate = "01/01/2021";
  String get startdate => _startdate;

  String _name = "";
  String get name => _name;

  double _allowance = 500;
  double get allowance => _allowance;

  String _unitvalue = "¥";
  String get unitvalue => _unitvalue;

  String _version = "0.0.0";
  String get version => _version;

  List<int> _counter = List.generate(120, (_) => 1);
  List<int> get counter => _counter;

  List<List<int>> _datelist = List.generate(120, (_) =>
    List.generate(30, (_) => 0)
  );
  List<List<int>> get datelist => _datelist;

  List<List<String>> _desclist = List.generate(120, (_) =>
    List.generate(30, (_) => "")
  );
  List<List<String>> get desclist => _desclist;

  List<List<double>> _amntlist = List.generate(120, (_) =>
    List.generate(30, (_) => 0.0)
  );
  List<List<double>> get amntlist => _amntlist;

  List<double> _balancelist = List.generate(120, (_) => 0.0);
  List<double> get balancelist => _balancelist;

  List<double> _percentlist = List.generate(120, (_) => 0.0);
  List<double> get percentlist => _percentlist;

  List<List<double>> _balance = List.generate(10, 
    (_) => List.generate(12, (_) => 0.0)
  );
  List<List<double>> get balance => _balance;
  
  
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
    getBalance();
    getPercent();
  }

  void dispose() {
  }

  void changeSelectFlag() async{
    _selectflag = !selectflag;
    notifyListeners();
  }

  void changeLyFlag() async{
    _lyflag = !lyflag;
    notifyListeners();
  }

  void nextIndex() async{
    if (index < 120) {
      _index++;
      print("index: $index");
    }
    if (maxindex == index) {
      final prefs = await SharedPreferences.getInstance();
      _maxindex = index + 1;
      await prefs.setInt("maxindexkey", maxindex);
      print("maxindex: $maxindex");
    }
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
      await prefs.setString("startdatekey", DateTime.now().toDateString("01/01/2021"));
      await prefs.setBool("startdateflagkey", true);
      _index = 0;
    }
    _startdate = prefs.getString("startdatekey") ?? "01/01/2021";
    print("startdate: $startdate, index: $index");
    notifyListeners();
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    _index = startdate.toCurrentIndex();
    _maxindex = prefs.getInt("maxindexkey") ?? index + 1;
    _yearindex = DateTime.now().year - startdate.toYear();
    if (maxindex < index + 1) _maxindex = index + 1;
    //print("index: $index, maxindex: $maxindex, yearindex: $yearindex");
    notifyListeners();
  }

  void increaseYearIndex() async {
    if (yearindex < 9) {
      _yearindex++;
      print("yearindex: $yearindex");
      notifyListeners();
    }
  }

  void decreaseYearIndex() async {
    if (yearindex > 0) {
      _yearindex--;
    }
    print("yearindex: $yearindex");
    notifyListeners();
  }

  void increaseCounter() async{
    final prefs = await SharedPreferences.getInstance();
    _counter[index]++;
    prefs.setInt("counterkey$index", counter[index]);
    print("counter: ${counter[index]}");
    notifyListeners();
  }

  void decreaseCounter() async {
    final prefs = await SharedPreferences.getInstance();
    if (counter[index] > 1) {
      _counter[index]--;
      prefs.setInt("counterkey$index", counter[index]);
    }
    print("counter: ${counter[index]}");
    notifyListeners();
  }

  void getCounter() async{
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      _counter[i] = prefs.getInt("counterkey$i") ?? 1;
      //print("getCounter : ${counter[index]}");
    }
    notifyListeners();
  }

  void saveDateList(int id, int day) async{
    final prefs = await SharedPreferences.getInstance();
    _datelist[index][id] = day;
    await prefs.setInt("datekey${index}_$id", day);
    print("index: $index, id: $id, Date : $day");
    notifyListeners();
  }

  void getDateList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _datelist[i][id] = prefs.getInt("datekey${i}_$id") ?? 0;
      }
    }
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
      saveDateList(id, picked.day);
      getDateList();
    }
  }

  void saveDescList(int id, String description) async{
    final prefs = await SharedPreferences.getInstance();
    _desclist[index][id] = description;
    await prefs.setString("desckey${index}_$id", description);
    print("index: $index, id: $id, saveDescription : $description");
    notifyListeners();
  }

  void getDescList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _desclist[i][id] = prefs.getString("desckey${i}_$id") ?? "";
      }
    }
    notifyListeners();
  }

  void saveAmntList(int id, double amount) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("amntkey${index}_$id", amount);
    _amntlist[index][id] = amount;
    print("id: $id, saveAmount: $amount");
    saveBalance();
    savePercent();
    notifyListeners();
  }

  void getAmntList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _amntlist[i][id] = prefs.getDouble("amntkey${i}_$id") ?? 0.0;
      }
    }
    //print("${amntlist[index]}");
    notifyListeners();
  }

  void saveBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final monthindex = (startdate.toMonth() - 1 + index) % 12;
    final yearindex = index ~/ 12;
    _balancelist[index] = amntlist.toBalance(index, counter);
    _balance[yearindex][monthindex] = amntlist.toBalance(index, counter);
    await prefs.setDouble("balancelistkey$index", amntlist.toBalance(index, counter));
    await prefs.setDouble("balancekey$index", amntlist.toBalance(index, counter));
    print("saveBalance: ${balancelist[index]}");
    notifyListeners();
  }

  void getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      final monthindex = (startdate.toMonth() - 1 + i) % 12;
      final yearindex = i ~/ 12;
      _balancelist[i] = prefs.getDouble("balancelistkey$i") ?? 0.0;
      _balance[yearindex][monthindex] = prefs.getDouble("balancekey$i") ?? 0.0;
    }
    //print("getBalance: ${balancelist[index]}");
    notifyListeners();
  }

  void savePercent() async {
    final prefs = await SharedPreferences.getInstance();
    _percentlist[index] = amntlist.toPercent(index, counter);
    await prefs.setDouble("percentkey$index", percentlist[index]);
    print("savePercent: ${percentlist[index]}");
    notifyListeners();
  }

  void getPercent() async {
    final prefs = await SharedPreferences.getInstance();
    for (int index = 0; index < maxindex; index++) {
      _percentlist[index] = prefs.getDouble("percentkey$index") ?? 0;
    }
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
    print("saveName : ${name}");
    notifyListeners();
  }

  void getAllowance() async {
    final prefs = await SharedPreferences.getInstance();
    _allowance = prefs.getDouble("allowancekey") ?? 500;
    //print("getAllowance : ${allowance}");
    notifyListeners();
  }

  void saveAllowance(double? doubleallowance) async {
    final prefs = await SharedPreferences.getInstance();
    if ((doubleallowance ?? 0.0) != 0) {
      await prefs.setDouble("allowancekey", doubleallowance as double);
    }
    print("saveAllowance : ${allowance}");
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
    print("saveUnit : ${unitvalue}");
    notifyListeners();
  }

  void getVersionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    //print("getVersion : ${version}");
    notifyListeners();
  }
}
