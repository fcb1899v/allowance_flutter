import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';
import 'dart:async';
import 'LoginView/LoginPage.dart';
import 'MainView/mainViewModel.dart';
import 'MainView/mainHomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  Firebase.initializeApp();
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(mainViewModel()),
      initialRoute: "/l",
      routes: {
        "/l": (context) => LoginPage(mainViewModel()),
        "/h":  (context) => MainHomePage(mainViewModel()),
      },
      debugShowCheckedModeBanner: false,
      title: "Allowance App",
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: 'defaultFont',
        brightness: Brightness.light,
        primaryColor: Colors.pinkAccent[100],
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.lightBlue)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  Widget build(BuildContext context) => LoginPage(mainViewModel());
}

