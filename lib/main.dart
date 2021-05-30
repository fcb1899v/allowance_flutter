import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui';
import 'dart:async';
import 'MainView/mainViewModel.dart';
import 'MainView/mainHomePage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Admob.initialize();
  //向き指定
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,//縦固定
  // ]);
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      initialRoute: "/",
      routes: {
        //"/summary": (context) => SummaryPage(mainViewModel()),
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
  Widget build(BuildContext context) => MainHomePage(mainViewModel());
}
