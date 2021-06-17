import 'package:allowance_app/MainView/mainHomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebaseAuth.dart';
import '../MainView/mainViewModel.dart';

class loginBody extends StatefulWidget {
  final mainViewModel viewModel;
  loginBody(this.viewModel);
  @override
  _loginBodyState createState() => _loginBodyState(viewModel);
}

class _loginBodyState extends State<loginBody> {
  final mainViewModel viewModel;
  _loginBodyState(this.viewModel);

  String inputemail = "";
  String inputpassword = "";
  String emaillabel = "email";
  String passwordlabel = "password"; // (8-20 charactors)
  String dialogtitle = "";
  String dialogmessage = "";
  bool isEmailInput = false;
  bool isPasswordInput = false;

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0,),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            SizedBox(height: 30,),
            loginTitle(context, "Login"),
            SizedBox(height: 30,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                color: Colors.white,
                child: TextFormField(
                  style: TextStyle(
                    decorationColor: Colors.white,
                    color: Colors.lightBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "defaultfont",
                  ),
                  validator: (value) => isBlank(value) ? 'Enter' : null,
                  onChanged: (value) {
                    isEmailInput = (value.length != 0);
                    if (isNotBlank(value)) inputemail = value;
                    print("email: $inputemail");
                    setState(() {});
                  },
                  cursorColor: Colors.lightBlue,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle,),
                    labelText: emaillabel,
                    labelStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    hintText: AppLocalizations.of(context)!.enter,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  autofocus: true,
                  obscureText: false,
                ),
              ),
            ),
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                color: Colors.white,
                child: TextFormField(
                  style: TextStyle(
                    decorationColor: Colors.white,
                    color: Colors.lightBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "defaultfont",
                  ),
                  validator: (value) => isBlank(value) ? 'Enter' : null,
                  onChanged: (value) {
                    isPasswordInput = (value.length > 7 && value.length < 21);
                    if (isNotBlank(value)) inputpassword = value;
                    print("password: $inputpassword");
                    setState(() {});
                  },
                  cursorColor: Colors.lightBlue,
                  decoration: InputDecoration(
                    icon: Icon(Icons.security,),
                    labelText: passwordlabel,
                    labelStyle: TextStyle(
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    hintText: AppLocalizations.of(context)!.enter,
                    hintStyle: TextStyle(color: Colors.grey[400]),
                  ),
                  autofocus: false,
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 30,),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: (isEmailInput && isPasswordInput) ? Colors.lightBlue: Colors.grey,
                child: TextButton(
                  child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "defaultfont",
                    ),
                  ),
                  onPressed: () async {
                    if (isEmailInput && isPasswordInput) {
                      // Firebase 認証
                      final auth = FirebaseAuth.instance;
                      try {
                        // メール/パスワードでログイン
                        UserCredential result = await auth.signInWithEmailAndPassword(
                          email: inputemail,
                          password: inputpassword,
                        );
                        // ログインに成功した場合
                        User? user = result.user;
                        if (user != null && user.emailVerified) {
                          user = auth.currentUser;
                          showLoginAlertDialog(context,
                            "Successful",
                            "",
                            Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) => MainHomePage(viewModel)),
                                (_) => false,
                            )
                          );
                          viewModel.stateLogin();
                          print("Login: ${viewModel.isLogin}");
                        } else if (user != null){
                          await user.sendEmailVerification();
                          showLoginAlertDialog(context,
                            "Sent verified email",
                            "Confirm your email",
                            null,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        showLoginAlertDialog(context,
                          "Authentification error",
                          e.code.loginErrorMessage(),
                          null,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.lightBlue,
                child: TextButton(
                  child: Text("No login start",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "defaultfont",
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => MainHomePage(viewModel)),
                      (_) => false);
                      viewModel.stateLogin();
                      print("No login start: ${viewModel.isLogin}");
                    });
                  },
                ),
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.lightBlue,
                child: TextButton(
                  child: Text("Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "defaultfont",
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      viewModel.moveSignUp();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}