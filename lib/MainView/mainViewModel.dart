import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../SpendAllowance.dart';

class mainViewModel extends Model {

  int _index = 0;
  int get index => _index;

  int _counter = 3;
  int get counter => _counter;

  String _unitvalue = "¥";
  String get unitvalue => _unitvalue;

  List<int> _amntlist = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,];
  List<int> get amntlist => _amntlist;

  List<String> _desclist = ["", "", "", "", "", "", "", "", "", "",];
  List<String> get desclist => _desclist;

  String _name = "";
  String get name => _name;

  DateTime? _startdate = null;
  DateTime? get startdate => _startdate;

  int _allowance = 500;
  int get allowance => _allowance;

  void refresh() {
    print("Refresh");
    notifyListeners();
  }

  void getNowIndex() {
    _index = startdate.defYear() * 12 + startdate.defMonth();
    print("index : ${_index}");
    notifyListeners();
  }

  void increaseIndex() async {
    _index++;
    print("increaseindex : ${_index}");
    notifyListeners();
  }

  void decreaseIndex() async {
    if (index > 0) { _index--; }
    print("decreaseindex : ${_index}");
    notifyListeners();
  }

  void getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("counterkey${index}") ?? 3;
    print("Index : ${index}, getCounter : ${_counter}");
    notifyListeners();
  }

  void saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("counterkey${index}", _counter);
    print("Index : ${index}, saveCounter : ${_counter}");
    notifyListeners();
  }

  void increaseCounter() async {
    if (counter < 10) { _counter++; }
    print("increaseCounter : ${_counter}");
    saveCounter();
    notifyListeners();
  }

  void decreaseCounter() async {
    if (counter > 1) { _counter--; }
    print("decreaseCounter : ${_counter}");
    saveCounter();
    notifyListeners();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("namekey") ?? "Not set";
    print("getName : ${_name}");
    notifyListeners();
  }

  void saveName(String? stringname) async {
    final prefs = await SharedPreferences.getInstance();
    if (stringname != null || stringname != "") {
      await prefs.setString("namekey", stringname!);
    }
    print("saveName : ${stringname}");
    notifyListeners();
  }

  void getAllowance() async {
    final prefs = await SharedPreferences.getInstance();
    _allowance = prefs.getInt("allowancekey") ?? 500;
    //print("getAllowance : ${_allowance}");
    notifyListeners();
  }

  void saveAllowance(int? intallowance) async {
    final prefs = await SharedPreferences.getInstance();
    if (intallowance != null || intallowance != 0) {
      await prefs.setInt("allowancekey", intallowance!);
    }
    //print("saveAllowance : ${intallowance}");
    notifyListeners();
  }

  void getUnit() async {
    final prefs = await SharedPreferences.getInstance();
    _unitvalue = prefs.getString("unitkey") ?? "¥";
    //print("getUnit : ${_unitvalue}");
    notifyListeners();
  }

  void saveUnit(String? unit) async {
    final prefs = await SharedPreferences.getInstance();
    if (unit != null || unit != "") {
      await prefs.setString("unitkey", unit!);
    }
    //print("saveUnit : ${_unitvalue}");
    notifyListeners();
  }

  void getDesc(int i) async {
    final prefs = await SharedPreferences.getInstance();
    desclist[i] = prefs.getString("desckey${index}_${i + 1}") ?? "";
    //print("desclist[i] : ${desclist[i]}");
    notifyListeners();
  }

  void getDescList() async {
    getCounter();
    for (int i = 0; i < _counter; i++) {
      getDesc(i);
    }
    //print("getDescList");
    notifyListeners();
  }

  void saveDesc(String desc, int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("desckey${index}_${i + 1}", desc);
    //print("saveDesc");
    notifyListeners();
  }

  void getAmnt(int i) async {
    final prefs = await SharedPreferences.getInstance();
    amntlist[i] = prefs.getInt("amntkey${index}_${i + 1}") ?? 0;
    //print("amntlist[i] : ${amntlist[i]}");
    notifyListeners();
  }

  void getAmntList() async {
    getCounter();
    for (int i = 0; i < counter; i++) {
      getAmnt(i);
      print("$i");
    }
    //print("getAmntList");
    notifyListeners();
  }

  void saveAmnt(int? amnt, int i) async {
    final prefs = await SharedPreferences.getInstance();
    if (amnt != null) {
      await prefs.setInt("amntkey${index}_${i + 1}", amnt);
    }
    //print("saveAmnt");
    notifyListeners();
  }

  void init()
  {
    getName();
    getAllowance();
    getUnit();
    getNowIndex();
    getCounter();
    getDescList();
    getAmntList();
  }

  void dispose() {
    getName();
    getAllowance();
    getUnit();
    getNowIndex();
    getCounter();
    getDescList();
    getAmntList();
  }
}
