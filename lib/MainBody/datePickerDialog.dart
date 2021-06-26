import 'package:flutter/material.dart';
import '/MainView/extension.dart';

DateTime? showDatePickerDialog(BuildContext context, Color color, String startdate, int index) {
  showDatePicker(
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: color, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.blueGrey, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: color, // button text color
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "defaultfont",
                )
            ),
          ),
        ),
        child: child!,
      );
    },
    context: context,
    initialDate: startdate.toDisplayDate(index),
    firstDate: DateTime(startdate.toDisplayDate(index).year - 1),
    lastDate: DateTime(startdate.toDisplayDate(index).year + 1),
  );
}