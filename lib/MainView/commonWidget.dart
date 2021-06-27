import 'package:flutter/material.dart';

void pushPage(BuildContext context, String page) {
  Navigator.of(context).pushNamedAndRemoveUntil(page, (_) => false);
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

TextStyle underlineTextStyle(Color color, double size, font) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: font,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );
}

