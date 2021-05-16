import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainViewModel extends Model {

  int _counter = 3;
  int get counter => _counter;

  List<int> _amntlist = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0,];
  List<int> get amntlist => _amntlist;

  List<String> _desclist = ["", "", "", "", "", "", "", "", "", "",];
  List<String> get desclist => _desclist;

  void refresh() {
    print("Refresh");
    notifyListeners();
  }

  void getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("counterkey") ?? 3;
    print("getCounter : ${_counter}");
    notifyListeners();
  }

  void saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("counterkey", _counter);
    print("saveCounter : ${_counter}");
    notifyListeners();
  }

  void increaseCounter() async {
    if (counter < 10) { _counter++; }
    print("increaseCounter : ${_counter}");
    saveCounter();
    notifyListeners();
  }

  void decreaseCounter() async {
    if (counter > 2) { _counter--; }
    print("decreaseCounter : ${_counter}");
    saveCounter();
    notifyListeners();
  }

  void getDesc(int i) async {
    final prefs = await SharedPreferences.getInstance();
    desclist[i] = prefs.getString("desckey${i + 1}") ?? "";
    print("desclist[i] : ${desclist[i]}");
    notifyListeners();
  }

  void getDescList() async {
    getCounter();
    for (int i = 0; i < _counter; i++) {
      getDesc(i);
    }
    print("getDescList");
    notifyListeners();
  }

  void saveDesc(String desc, int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("desckey${i + 1}", desc);
    print("saveDesc");
    notifyListeners();
  }

  void getAmnt(int i) async {
    final prefs = await SharedPreferences.getInstance();
    amntlist[i] = prefs.getInt("amntkey${i + 1}") ?? 0;
    //print("amntlist[i] : ${amntlist[i]}");
    notifyListeners();
  }

  void getAmntList() async {
    getCounter();
    for (int i = 0; i < _counter; i++) {
      getAmnt(i);
      print("$i");
    }
    print("getAmntList");
    notifyListeners();
  }

  void saveAmnt(int amnt, int i) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("amntkey${i + 1}", amnt);
    print("saveAmnt");
    notifyListeners();
  }

  void init() {}

  void dispose() {}
}
