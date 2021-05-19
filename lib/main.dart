import 'package:allowance_app/MainView/mainViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'dart:ui';
import 'dart:async';

import 'MainView/allowance.dart';
import 'SettingsView/settingsView.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  //向き指定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,//縦固定
  // ]);
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Allowance App",
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pinkAccent[100],
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.lightBlue)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
      initialRoute: "/",
      routes: {
        "/SettingsView": (context) => settingsView(mainViewModel()),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => AllowancePage(mainViewModel());
}