
import '/MainView/commonWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiver/strings.dart';
import 'firebaseAuth.dart';

class passwordResetButton extends StatefulWidget{
  passwordResetButton();
  @override
  passwordResetButtonState createState() => new passwordResetButtonState();
}

class passwordResetButtonState extends State<passwordResetButton> {
  passwordResetButtonState();
  Widget build(BuildContext context) {
    String title = "";
    String message = "";
    String inputemail = "";
    return TextButton(
      child: Text(AppLocalizations.of(context)!.forgotpass,
        style: commonButtonStyle(),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.passwordreset,
                style: commonTextStyle(),
              ),
              content: TextField(
                style: commonTextStyle(),
                onChanged: (value) {
                  if (isNotBlank(value)) inputemail = value;
                },
                controller: TextEditingController(),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue, width: 1.0),
                  ),
                  hintText: AppLocalizations.of(context)!.settingdeschint,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                autofocus: true,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel,
                    style: commonTextStyle(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.ok,
                    style: commonTextStyle(),
                  ),
                  onPressed: () async {
                    if (isNotBlank(inputemail)) {
                      // Firebase 認証
                      final auth = FirebaseAuth.instance;
                      try {
                        // パスワードリセットメールを送信
                        await auth.sendPasswordResetEmail(email: inputemail,);
                        title = AppLocalizations.of(context)!.sentpassresetmail;
                        showSuccessSnackBar(context, title);
                        await Future.delayed(Duration(seconds: 3));
                        Navigator.of(context).pop();
                      } catch (_) {
                        title = AppLocalizations.of(context)!.sendmailerror;
                        message = AppLocalizations.of(context)!.cantsentpassresetmail;
                        showLoginAlertDialog(context, title, message);
                        await Future.delayed(Duration(seconds: 3));
                        Navigator.of(context).pop();
                      }
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}