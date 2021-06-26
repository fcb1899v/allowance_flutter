import 'package:flutter/material.dart';

void pushPage(BuildContext context, String page) {
  Navigator.of(context).pushNamedAndRemoveUntil(page, (_) => false);
}

Widget titleView(BuildContext context, String title) {
  final lang = Localizations.localeOf(context).languageCode;
  return Text(title,
    style: TextStyle(
      color: Colors.white,
      fontSize: (lang == "ja") ? 18: 24,
      fontWeight: FontWeight.bold,
      fontFamily: (lang == "ja") ? 'defaultfont': 'enAccent',
    ),
  );
}

TextStyle commonTextStyle() {
  return TextStyle(
    decorationColor: Colors.white,
    color: Colors.lightBlue,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "defaultfont",
  );
}

TextStyle commonButtonStyle() {
  return TextStyle(
    decorationColor: Colors.lightBlue,
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: "defaultfont",
  );
}
