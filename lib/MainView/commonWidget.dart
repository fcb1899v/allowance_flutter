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

DataColumn dataColumnTitle(BuildContext context, String columntitle) {
  var lang = Localizations.localeOf(context).languageCode;
  return DataColumn(
    label: Text(columntitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: (lang == "ja") ? 'jaAccent': 'enAccent',
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Icon customIcon(IconData icon, Color color, double size) {
  return Icon(icon,
    color: color,
    size: size,
  );
}

TextStyle customTextStyle(Color color, double size, font) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: font,
  );
}

TextStyle settingsTextStyle(Color color, double size, font) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: font,
  );
}

TextStyle customShadowTextStyle(Color color, double size, font) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: font,
    shadows: [ Shadow(
      offset: Offset(2.0, 2.0),
      blurRadius: 1.0,
      color: Colors.lightBlue,
    )],
  );
}


