import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';

Widget loginTitle(BuildContext context, String title) {
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

void showLoginAlertDialog(BuildContext context, String title, String message, action) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              action;
            },
          ),
        ],
      );
    },
  );
}

extension LoginStringExt on String {

  String loginErrorMessage() {
    String dialogmessage = "";
    switch (this) {
      case 'invalid-email':
        dialogmessage = 'メールアドレスが間違っています。';
        break;
      case 'wrong-password':
        dialogmessage = 'Wrong password provided for that user.';
        break;
      case 'user-not-found':
        dialogmessage = 'No user found for that email.';
        break;
      case 'user-disabled':
        dialogmessage = 'このメールアドレスは無効になっています。';
        break;
      case 'too-many-requests':
        dialogmessage = '回線が混雑しています。もう一度試してみてください。';
        break;
      case 'operation-not-allowed':
        dialogmessage = 'メールアドレスとパスワードでのログインは有効になっていません。';
        break;
      case 'email-already-in-use':
        dialogmessage = 'The account already exists for that email.';
        break;
      case 'weak-password':
        dialogmessage = 'The password provided is too weak.';
        break;
      default:
        dialogmessage = '予期せぬエラーが発生しました。';
        break;
    }
    print(dialogmessage);
    return dialogmessage;
  }
}