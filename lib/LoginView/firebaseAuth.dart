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
    message = e.code.loginErrorMessage();
    showLoginAlertDialog(context, title, message);
  }
}

extension LoginStringExt on String {

  String loginErrorMessage() {
    String dialogmessage = "";
    switch (this) {
      case 'invalid-email':
        dialogmessage = 'This email is invalid.';
        break;
      case 'wrong-password':
        dialogmessage = 'Wrong password provided for this user.';
        break;
      case 'user-not-found':
        dialogmessage = 'No user found for this email.';
        break;
      case 'user-disabled':
        dialogmessage = 'This user disabled.';
        break;
      case 'too-many-requests':
        dialogmessage = 'Too many requests to log into this account.';
        break;
      case 'operation-not-allowed':
        dialogmessage = 'Server error, please try again later.';
        break;
      case 'email-already-in-use':
        dialogmessage = 'The account already exists for this email.';
        break;
      case 'weak-password':
        dialogmessage = 'The password provided is too weak.';
        break;
      default:
        dialogmessage = 'Login failed. Please try again.';
        break;
    }
    print(dialogmessage);
    return dialogmessage;
  }
}