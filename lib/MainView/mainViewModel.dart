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

  double _startassets = 0.0;
  double get startassets => _startassets;

  List<List<Map>> _spendlist = List.generate(120, (_) =>
      List.generate(30, (_) => {"date": 100, "desc": "", "amnt": 0.0})
  );
  List<List<Map>> get spendlist => _spendlist;

  List<double> _balancelist = List.generate(120, (_) => 0.0);
  List<double> get balancelist => _balancelist;

  List<double> _percentlist = List.generate(120, (_) => 0.0);
  List<double> get percentlist => _percentlist;

  List<List<double>> _assets = List.generate(10,
    (_) => List.generate(12, (_) => 0.0)
  );
  List<List<double>> get assets => _assets;

  double _maxassets = 0.0;
  double get maxassets => _maxassets;

  List<List<double>> _balance = List.generate(10,
          (_) => List.generate(12, (_) => 0.0)
  );
  List<List<double>> get balance => _balance;

  double _maxbalance = 0.0;
  double get maxbalance => _maxbalance;

  List<List<double>> _spend = List.generate(10,
          (_) => List.generate(12, (_) => 0.0)
  );
  List<List<double>> get spend => _spend;

  double _maxspend = 0.0;
  double get maxspend => _maxspend;

  String _unitvalue = "¥";
  String get unitvalue => _unitvalue;

  String _version = "0.0.0";
  String get version => _version;

  List<int> _counter = List.generate(120, (_) => 1);
  List<int> get counter => _counter;

  //データの初期化
  void init()
  {
    getName();
    getUnit();
    getVersionNumber();
    getStartDate();
    getCurrentIndex();
    getCounter();
    getSpendList();
    getAssets();
    getSpend();
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
    }
    notifyListeners();
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

  void deleteSpend(int id) async {
    final prefs = await SharedPreferences.getInstance();
    spendlist[index].removeAt(id);
    spendlist[index].add({"date": 100, "desc": "", "amnt": 0.0});
    spendlist[index].sort((a, b) => a["date"].compareTo(b["date"]));
    for (int id = 0; id < counter[index]; id++) {
      final date = spendlist[index][id]["date"];
      final desc = spendlist[index][id]["desc"];
      final amnt = spendlist[index][id]["amnt"];
      await prefs.setInt("datekey${index}_$id", date);
      await prefs.setString("desckey${index}_$id", desc);
      await prefs.setDouble("amntkey${index}_$id", amnt);
    }
    decreaseCounter();
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void getSpendList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _spendlist[i][id]["date"] = prefs.getInt("datekey${i}_$id") ?? 0;
        _spendlist[i][id]["desc"] = prefs.getString("desckey${i}_$id") ?? "";
        _spendlist[i][id]["amnt"] = prefs.getDouble("amntkey${i}_$id") ?? 00.0;
      }
    }
    notifyListeners();
  }

  void saveSpendList(int day, String description, double amount) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("datekey${index}_${counter[index] - 2}", day);
    await prefs.setString("desckey${index}_${counter[index] - 2}", description);
    await prefs.setDouble("amntkey${index}_${counter[index] - 2}", amount);
    _spendlist[index][counter[index] - 2]["date"] = day;
    _spendlist[index][counter[index] - 2]["desc"] = description;
    _spendlist[index][counter[index] - 2]["amnt"] = amount;
    spendlist[index].sort((a, b) => a["date"].compareTo(b["date"]));
    for (int i = 0; i < counter[index]; i++) {
      int date = spendlist[index][i]["date"];
      String desc = spendlist[index][i]["desc"];
      double amnt = spendlist[index][i]["amnt"];
      await prefs.setInt("datekey${index}_$i", date);
      await prefs.setString("desckey${index}_$i", desc);
      await prefs.setDouble("amntkey${index}_$i", amnt);
    }
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void saveDateList(int id, int day) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("datekey${index}_$id", day);
    _spendlist[index][id]["date"] = day;
    spendlist[index].sort((a, b) => a["date"].compareTo(b["date"]));
    for (int i = 0; i < counter[index]; i++) {
      int date = spendlist[index][i]["date"];
      String desc = spendlist[index][i]["desc"];
      double amnt = spendlist[index][i]["amnt"];
      await prefs.setInt("datekey${index}_$i", date);
      await prefs.setString("desckey${index}_$i", desc);
      await prefs.setDouble("amntkey${index}_$i", amnt);
    }
    print("${spendlist[index]}");
    notifyListeners();
  }

  void getDateList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _spendlist[i][id]["date"] = prefs.getInt("datekey${i}_$id") ?? 0;
      }
    }
    notifyListeners();
  }

  //DatePickerで日付を記録
  Future selectDate(BuildContext context, int id) async {
    Color? customcolor = (spendlist[index][id]["amnt"] > 0.0) ? Colors.pinkAccent: Colors.lightBlue;
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: customcolor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.blueGrey, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: customcolor, // button text color
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "defaultfont",
                )
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: startdate.toDisplayDate(index),
      firstDate: DateTime(startdate.toDisplayDate(index).year - 1),
      lastDate: DateTime(startdate.toDisplayDate(index).year + 1),
    );
    if(picked != null) {
      print("picked.day: ${picked.day}");
      saveDateList(id, picked.day);
      getDateList();
    }
    notifyListeners();
  }

  void saveDescList(int id, String description) async{
    final prefs = await SharedPreferences.getInstance();
    _spendlist[index][id]["desc"] = description;
    await prefs.setString("desckey${index}_$id", description);
    print("index: $index, id: $id, saveDescription : $description");
    notifyListeners();
  }

  void getDescList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _spendlist[i][id]["desc"] = prefs.getString("desckey${i}_$id") ?? "";
      }
    }
    notifyListeners();
  }

  void saveAmntList(int id, double amount) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("amntkey${index}_$id", amount);
    _spendlist[index][id]["amnt"] = amount;
    print("id: $id, saveAmount: $amount");
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void getAmntList() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      for (int id = 0; id < counter[i]; id++) {
        _spendlist[i][id]["amnt"] = prefs.getDouble("amntkey${i}_$id") ?? 0.0;
      }
    }
    //print("${amntlist[index]}");
    notifyListeners();
  }

  void getBalance() async {
    final initialmaxbalance = (unitvalue == "¥") ? 500.0: 5.00;
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      final monthindex = (startdate.toMonth() - 1 + i) % 12;
      final yearindex = i ~/ 12;
      _balancelist[i] = prefs.getDouble("balancelistkey$i") ?? 0.0;
      _balance[yearindex][monthindex] = prefs.getDouble("balancekey$i") ?? 0.0;
    }
    _maxbalance = prefs.getDouble("maxbalancekey") ?? initialmaxbalance;
    //print("getBalance: ${balancelist[index]}");
    notifyListeners();
  }

  void saveBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final monthindex = (startdate.toMonth() - 1 + index) % 12;
    final yearindex = index ~/ 12;
    _balancelist[index] = spendlist.toBalance(index, counter);
    _balance[yearindex][monthindex] = spendlist.toBalance(index, counter);
    _maxbalance = balancelist.toMaxBalance();
    await prefs.setDouble("balancelistkey$index", spendlist.toBalance(index, counter));
    await prefs.setDouble("balancekey$index", spendlist.toBalance(index, counter));
    await prefs.setDouble("maxbalancekey", balancelist.toMaxBalance());
    print("saveBalance: ${balancelist[index]}");
    print("saveMaxBalance: $maxbalance");
    notifyListeners();
  }

  void savePercent() async {
    final prefs = await SharedPreferences.getInstance();
    _percentlist[index] = spendlist.toPercent(index, counter);
    await prefs.setDouble("percentkey$index", percentlist[index]);
    print("savePercent: ${percentlist[index]}");
    notifyListeners();
  }

  void getSpend() async {
    final initialmaxspend = (unitvalue == "¥") ? 500.0: 5.00;
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      final monthindex = (startdate.toMonth() - 1 + i) % 12;
      final yearindex = i ~/ 12;
      _spend[yearindex][monthindex] = prefs.getDouble("spendkey$i") ?? 0.0;
    }
    _maxspend = prefs.getDouble("maxspendkey") ?? initialmaxspend;
    //print("getSpend: $spend}");
    notifyListeners();
  }

  void saveSpend() async {
    final prefs = await SharedPreferences.getInstance();
    double spend = 0;
    double maxspend = 0;
    for (int i = 0; i < maxindex; i++) {
      int monthindex = (startdate.toMonth() - 1 + i) % 12;
      int yearindex = i ~/ 12;
      spend += spendlist.toSpendSum(i, counter[index]);
      _spend[yearindex][monthindex] = spend;
      if (spend > maxspend) maxspend = spend;
      await prefs.setDouble("spendkey$i", spend);
      await prefs.setDouble("maxspendkey", maxspend);
    }
    print("saveSpend: $spend");
    print("saveMaxSpend: $maxspend");
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
    //print("getName : $name");
    notifyListeners();
  }

  void saveName(String? stringname) async {
    final prefs = await SharedPreferences.getInstance();
    if (isNotBlank(stringname)) {
      await prefs.setString("namekey", stringname!);
    }
    print("saveName : $name");
    notifyListeners();
  }

  void getAssets() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      int monthindex = (startdate.toMonth() - 1 + i) % 12;
      int yearindex = i ~/ 12;
      _assets[yearindex][monthindex] = prefs.getDouble("assetskey_$i") ?? 0.0;
    }
    _startassets = prefs.getDouble("startassetskey") ?? 0.0;
    _maxassets = prefs.getDouble("maxassetskey") ?? 0.0;
    //print("getAssets : $assets");
    notifyListeners();
  }

  void saveStartAssets(double assets) async {
    final prefs = await SharedPreferences.getInstance();
    if (assets >= 0) {
      await prefs.setDouble("startassetskey", assets);
    }
    print("saveStartAssets : $startassets");
    saveAssets();
    notifyListeners();
  }

  void saveAssets() async {
    final prefs = await SharedPreferences.getInstance();
    double asset = startassets;
    double maxasset = startassets;
    for (int i = 0; i < maxindex; i++) {
      int monthindex = (startdate.toMonth() - 1 + i) % 12;
      int yearindex = i ~/ 12;
      asset += balancelist[i];
      await prefs.setDouble("assetskey_$i", asset);
      _assets[yearindex][monthindex] = asset;
      if (asset > maxasset) maxasset = asset;
    }
    _maxassets = maxasset;
    await prefs.setDouble("maxassetskey", maxasset);
    print("saveAssets : $assets, saveMaxAssets : $maxassets" );
    notifyListeners();
  }

  void getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    _unitvalue = prefs.getString("unitkey") ?? "¥";
    //print("getUnit : $unitvalue");
    notifyListeners();
  }

  void saveUnit(String? unit) async {
    final prefs = await SharedPreferences.getInstance();
    if (isNotBlank(unit)) {
      await prefs.setString("unitkey", unit!);
    }
    print("saveUnit : $unitvalue");
    notifyListeners();
  }

  void getVersionNumber() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    //print("getVersion : ${version}");
    notifyListeners();
  }
}
