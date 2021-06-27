import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/MainView/commonWidget.dart';

void showSuccessSnackBar(BuildContext context, String title) {
  final snackBar = SnackBar(
    backgroundColor: Colors.white,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(CupertinoIcons.hand_thumbsup,
          color: Colors.lightBlue,
        ),
        Text(" $title",
          style: TextStyle(
            color: Colors.lightBlue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "defaultfont",
          ),
        ),
      ],
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showLoginAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return CupertinoAlertDialog(
        title: Row(
          children: [
            Icon(CupertinoIcons.info_circle),
            Text(" $title"),
          ]
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              print("OK");
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

// Firebase 認証
Future<void> tryAuth(
    BuildContext context,
    bool isMoveSignup,
    String inputemail,
    String inputpassword,
    String inputconfirmpass,
    void action,
  ) async {

  final auth = FirebaseAuth.instance;
  var title = "";
  var message = "";

  try {
    // メール/パスワードでログイン
    UserCredential result = (!isMoveSignup) ?
    await auth.signInWithEmailAndPassword(
      email: inputemail,
      password: inputpassword,
    ):
    await auth.createUserWithEmailAndPassword(
      email: inputemail,
      password: inputpassword,
    );
    // ログインに成功した場合
    User? user = result.user;
    if (user != null && user.emailVerified) {
      user = auth.currentUser;
      title = (!isMoveSignup) ?
        AppLocalizations.of(context)!.loginsuccess:
        AppLocalizations.of(context)!.signupsuccess;
      showSuccessSnackBar(context, title);
      action;
      await new Future.delayed(new Duration(seconds: 2));
      pushPage(context, "/h");
    } else if (user != null){
      await user.sendEmailVerification();
      title = AppLocalizations.of(context)!.sentverifiedemail;
      showSuccessSnackBar(context, title);
    }
  } on FirebaseAuthException catch (e) {
    title = (!isMoveSignup) ?
      AppLocalizations.of(context)!.loginerror:
      AppLocalizations.of(context)!.signuperror;
    message = e.code.loginErrorMessage(context, (!isMoveSignup) ?
      AppLocalizations.of(context)!.loginerrormessage:
      AppLocalizations.of(context)!.signuperrormessage,
    );
    showLoginAlertDialog(context, title, message);
  }
}

extension LoginStringExt on String {

  String loginErrorMessage(BuildContext context, String defaultmessage) {
    String dialogmessage = "";
    switch (this) {
      case 'invalid-email':
        dialogmessage = AppLocalizations.of(context)!.invalidemail;
        break;
      case 'wrong-password':
        dialogmessage = AppLocalizations.of(context)!.wrongpassword;
        break;
      case 'user-not-found':
        dialogmessage = AppLocalizations.of(context)!.usernotfound;
        break;
      case 'user-disabled':
        dialogmessage = AppLocalizations.of(context)!.userdisabled;
        break;
      case 'too-many-requests':
        dialogmessage = AppLocalizations.of(context)!.toomanyrequests;
        break;
      case 'operation-not-allowed':
        dialogmessage = AppLocalizations.of(context)!.operationnotallowed;
        break;
      case 'email-already-in-use':
        dialogmessage = AppLocalizations.of(context)!.emailalreadyinuse;
        break;
      case 'weak-password':
        dialogmessage = AppLocalizations.of(context)!.weakpassword;
        break;
      default:
        dialogmessage = defaultmessage;
        break;
    }
    print("Error: $dialogmessage");
    return dialogmessage;
  }
}