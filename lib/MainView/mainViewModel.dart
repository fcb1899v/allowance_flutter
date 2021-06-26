import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiver/strings.dart';
import 'firebasefirestore.dart';
import 'extension.dart';
import 'dart:async';

// ignore: camel_case_types
class mainViewModel extends Model {

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  bool _isMoveSignup = false;
  bool get isMoveSignup => _isMoveSignup;

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

  double _initialassets = 0.0;
  double get initialassets => _initialassets;

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
    getStateLogin();
    getName();
    getUnit();
    getVersionNumber();
    getStartDate();
    getCurrentIndex();
    getCounter();
    //getFireStoreSpendList();
    getSpendList();
    getAssets();
    getSpend();
    getBalance();
    getPercent();
  }

  void dispose() {
  }

  void stateLogin() async{
    _isLogin = true;
    setSharedPrefBool("loginflagkey", true);
    print("isLogin: $isLogin");
    notifyListeners();
  }

  // void getFireStoreSpendList() async {
  //   for (int j = 0; j < maxindex; j++) {
  //     final docsnapshot = "$j".toDataDocRef().get();
  //     Map<String, dynamic>? data = docsnapshot.data() as Map<String, dynamic>;
  //     for (int i = 0; i < counter[j]; i++) {
  //       if (isNotBlank(data["$i"])) {
  //         _spendlist[j][i]["data"] = data["$i"] as Map<String, dynamic>;
  //       }
  //     }
  //   }
  //   notifyListeners();
  // }

  void stateLogout() async{
    _isLogin = false;
    setSharedPrefBool("loginflagkey", false);
    print("isLogin: $isLogin");
    notifyListeners();
  }

  void getStateLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLogin = prefs.getBool("loginflagkey") ?? false;
    //print("isLogin: $isLogin");
    notifyListeners();
  }

  void moveSignUp() async{
    _isMoveSignup = true;
    notifyListeners();
  }

  void moveLogin() async{
    _isMoveSignup = false;
    notifyListeners();
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
      _maxindex = index + 1;
      setSharedPrefInt("maxindexkey", maxindex);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!(prefs.getBool("startdateflagkey") ?? false)) {
      _startdate = DateTime.now().toDateString("01/01/2021");
      setSharedPrefString("startdatekey", startdate);
      setFirestoreData("settings", "start date", startdate);
      setSharedPrefBool("startdateflagkey", true);
      _index = 0;
    } else {
      _startdate = prefs.getString("startdatekey") ?? "01/01/2021";
    }
    //print("startdate: $startdate, index: $index");
    notifyListeners();
  }

  void getCurrentIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _index = startdate.toCurrentIndex();
    _maxindex = prefs.getInt("maxindexkey") ?? index + 1;
    _yearindex = startdate.toYearIndex();
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
    _counter[index]++;
    setSharedPrefInt("counterkey$index", counter[index]);
    print("counter: ${counter[index]}");
    notifyListeners();
  }

  void decreaseCounter() async {
    if (counter[index] > 1) {
      _counter[index]--;
      setSharedPrefInt("counterkey$index", counter[index]);
    }
    print("counter: ${counter[index]}");
    notifyListeners();
  }

  void getCounter() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      _counter[j] = prefs.getInt("counterkey$j") ?? 1;
      //print("getCounter : ${counter[index]}");
    }
    notifyListeners();
  }

  void deleteSpend(int id) async {
    spendlist[index].removeAt(id);
    spendlist[index].add({"date": 100, "desc": "", "amnt": 0.0});
    spendlist.dateSort(index);
    deleteFirestoreData("$index");
    decreaseCounter();
    for (int i = 0; i < counter[index]; i++) {
      setSharedPrefSpendList(spendlist, index, i);
      setFirestoreData("$index", "$i", spendlist.toMap(index, i));
    }
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void getSpendData(int id, int j) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _spendlist[j][id]["date"] = prefs.getInt("datekey${j}_$id") ?? 0;
    _spendlist[j][id]["desc"] = prefs.getString("desckey${j}_$id") ?? "";
    _spendlist[j][id]["amnt"] = prefs.getDouble("amntkey${j}_$id") ?? 0.0;
    notifyListeners();
  }

  void getSpendList() async {
    for (int j = 0; j < maxindex; j++) {
      for (int i = 0; i < counter[j]; i++) {
        getSpendData(i, j);
      }
    }
    notifyListeners();
  }

  void saveSpendList(int day, String description, double amount) async{
    _spendlist[index][counter[index] - 2] = {"date": day, "desc": description, "amnt": amount};
    setSharedPrefSpendList(spendlist, index, counter[index] - 2);
    spendlist.dateSort(index);
    for (int i = 0; i < counter[index]; i++) {
      setSharedPrefSpendList(spendlist, index, i);
      setFirestoreData("$index", "$i", spendlist.toMap(index, i));
    }
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void saveDateList(int id, int day) async{
    _spendlist[index][id]["date"] = day;
    setSharedPrefInt("datekey${index}_$id", day);
    spendlist.dateSort(index);
    for (int i = 0; i < counter[index]; i++) {
      setSharedPrefSpendList(spendlist, index, i);
      setFirestoreData("$index", "$i", spendlist.toMap(index, i));
    }
    print("${spendlist[index]}");
    notifyListeners();
  }

  void getDateList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      for (int i = 0; i < counter[j]; i++) {
        _spendlist[j][i]["date"] = prefs.getInt("datekey${j}_$i") ?? 0;
      }
    }
    notifyListeners();
  }

  //DatePickerで日付を記録
  Future selectDate(BuildContext context, int id) async {
    Color? customcolor = (spendlist[index][id]["amnt"] > 0.0) ? Colors.pinkAccent: Colors.lightBlue;
    DateTime? picked = await showDatePicker(
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
    if (picked != null) {
      print("picked.day: ${picked.day}");
      saveDateList(id, picked.day);
      getDateList();
    }
    notifyListeners();
  }

  void saveDescList(int id, String description) async {
    _spendlist[index][id]["desc"] = description;
    setSharedPrefString("desckey${index}_$id", description);
    setFirestoreData("$index", "$id", spendlist.toMap(index, id));
    print("index: $index, id: $id, saveDescription : $description");
    notifyListeners();
  }

  void getDescList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      for (int i = 0; i < counter[i]; i++) {
        _spendlist[j][i]["desc"] = prefs.getString("desckey${j}_$i") ?? "";
      }
    }
    notifyListeners();
  }

  void saveAmntList(int id, double amount) async{
    _spendlist[index][id]["amnt"] = amount;
    setSharedPrefDouble("amntkey${index}_$id", amount);
    setFirestoreData("$index", "$id", spendlist.toMap(index, id));
    print("id: $id, saveAmount: $amount");
    saveBalance();
    savePercent();
    saveAssets();
    saveSpend();
    notifyListeners();
  }

  void getAmntList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      for (int i = 0; i < counter[j]; i++) {
        _spendlist[j][i]["amnt"] = prefs.getDouble("amntkey${j}_$i") ?? 0.0;
      }
    }
    //print("${amntlist[index]}");
    notifyListeners();
  }

  void getBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      final monthindex = startdate.toMonthIndex(j);
      final yearindex = j ~/ 12;
      _balancelist[j] = prefs.getDouble("balancelistkey$j") ?? 0.0;
      _balance[yearindex][monthindex] = prefs.getDouble("balancekey$j") ?? 0.0;
    }
    _maxbalance = prefs.getDouble("maxbalancekey") ?? 1.0;
    //print("getBalance: ${balancelist[index]}");
    notifyListeners();
  }

  void saveBalance() async {
    final monthindex = startdate.toMonthIndex(index);
    final yearindex = index ~/ 12;
    _balancelist[index] = spendlist.toBalance(index, counter[index]);
    _balance[yearindex][monthindex] = balancelist[index];
    setSharedPrefDouble("balancelistkey$index", balancelist[index]);
    setSharedPrefDouble("balancekey$index", balancelist[index]);
    saveMaxBalance();
    print("saveBalance: ${balancelist[index]}, saveMaxBalance: $maxbalance");
    notifyListeners();
  }

  void saveMaxBalance() async{
    _maxbalance = balancelist.toMaxDouble();
    setSharedPrefDouble("maxbalancekey", maxbalance);
    print("saveMaxBalance: $maxbalance");
    notifyListeners();
  }

  void savePercent() async {
    _percentlist[index] = spendlist.toPercent(index, counter);
    setSharedPrefDouble("percentkey$index", percentlist[index]);
    print("savePercent: ${percentlist[index]}");
    notifyListeners();
  }

  void getSpend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < maxindex; i++) {
      final monthindex = startdate.toMonthIndex(i);
      final yearindex = i ~/ 12;
      _spend[yearindex][monthindex] = prefs.getDouble("spendkey$i") ?? 0.0;
    }
    _maxspend = prefs.getDouble("maxspendkey") ?? 1.0;
    //print("getSpend: $spend}");
    notifyListeners();
  }

  void saveSpend() async {
    final monthindex = startdate.toMonthIndex(index);
    final yearindex = index ~/ 12;
    _spend[yearindex][monthindex] = spendlist.toSpendSum(index, counter[index]);
    setSharedPrefDouble("spendkey$index", spend[yearindex][monthindex]);
    saveMaxSpend();
    print("saveSpend: ${spend[yearindex][monthindex]}, saveMaxSpend: $maxspend");
    notifyListeners();
  }

  void saveMaxSpend() async {
    _maxspend = spend.toMax();
    setSharedPrefDouble("maxspendkey", maxspend);
  }

  void getPercent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      _percentlist[j] = prefs.getDouble("percentkey$j") ?? 0;
    }
    notifyListeners();
  }

  void getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("namekey") ?? "Not set";
    //print("getName : $name");
    notifyListeners();
  }

  void saveName(String? stringname) async {
    if (isNotBlank(stringname)) {
      _name = stringname!;
      setSharedPrefString("namekey", name);
      setFirestoreData("settings", "name", name);
      print("save name : $name");
    }
    notifyListeners();
  }

  void getAssets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int j = 0; j < maxindex; j++) {
      final monthindex = startdate.toMonthIndex(j);
      final yearindex = j ~/ 12;
      _assets[yearindex][monthindex] = prefs.getDouble("assetskey_$j") ?? 0.0;
    }
    _initialassets = prefs.getDouble("initialassetskey") ?? 0.0;
    _maxassets = prefs.getDouble("maxassetskey") ?? 1.0;
    //print("getAssets : $assets");
    notifyListeners();
  }

  void saveInitialAssets(double iniassets) async {
    if (iniassets >= 0) {
      _initialassets = iniassets;
      setSharedPrefDouble("initialassetskey", initialassets);
      setFirestoreData("settings", "initial asset", initialassets);
      saveAssets();
    }
    print("save initial assets : $initialassets");
    notifyListeners();
  }

  void saveAssets() async {
    double asset = initialassets;
    for (int j = 0; j < maxindex; j++) {
      final monthindex = startdate.toMonthIndex(j);
      final yearindex = j ~/ 12;
      asset += balancelist[j];
      _assets[yearindex][monthindex] = asset;
      setSharedPrefDouble("assetskey_$j", asset);
    }
    saveMaxAssets();
    print("saveAssets : $asset, saveMaxAssets : $maxassets");
    notifyListeners();
  }

  void saveMaxAssets() async {
    _maxassets = assets.toMax();
    setSharedPrefDouble("maxassetskey", maxassets);
    print("saveMaxAssets : $maxassets" );
  }

  void getUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _unitvalue = prefs.getString("unitkey") ?? "¥";
    //print("getUnit : $unitvalue");
    notifyListeners();
  }

  void saveUnit(String? unit) async {
    if (isNotBlank(unit)) {
      _unitvalue = unit!;
      setSharedPrefString("unitkey", unitvalue);
      setFirestoreData("settings", "unit", unitvalue);
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
