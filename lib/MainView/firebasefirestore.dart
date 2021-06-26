import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension FirestoreStringExt on String {

  DocumentReference toUserDB() {
    return FirebaseFirestore.instance.collection("users").doc(this);
  }

  DocumentReference toDataDocRef() {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    return userid.toUserDB().collection("data").doc(this);
  }
}

Future<void> setFirestoreData(String document, String key, Object? setvalue) async {
  try {
    await document.toDataDocRef().set({key: setvalue}, SetOptions(merge : true))
      .then((value) => print("Set $key"));
  } catch (e) {
    print("Failed to set $key: $e");
  }
}

Future<void> deleteFirestoreData(String document) async {
  try {
    await document.toDataDocRef().delete()
      .then((value) => print("deleted"));
  } catch (e) {
    print("Failed to delete: $e");
  }
}

Future<void> getFirestoreData(String document) async {
  try {
    await document.toDataDocRef().get()
      .then((value) => print("deleted"));
  } catch (e) {
    print("Failed to delete: $e");
  }
}

Future<void> setSharedPrefDouble(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(key, value);
}

Future<void> setSharedPrefInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<void> setSharedPrefString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<void> setSharedPrefBool(String key, bool flag) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, flag);
}

Future<void> setSharedPrefSpendList(List<List<Map>> spendlist, int index, int id) async {
  setSharedPrefInt("datekey${index}_$id", spendlist[index][id]["date"]);
  setSharedPrefString("desckey${index}_$id", spendlist[index][id]["desc"]);
  setSharedPrefDouble("amntkey${index}_$id", spendlist[index][id]["amnt"]);
}
