import 'package:allowance_app/MainView/mainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'dart:async';

import 'MainView/allowance.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  //向き指定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,//縦固定
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static final String title = "Allowance App";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pinkAccent[100],
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.lightBlue)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(title: title),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => AllowancePage(mainViewModel());
}