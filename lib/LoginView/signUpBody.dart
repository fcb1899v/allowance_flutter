import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import '../MainView/mainViewModel.dart';
import 'firebaseAuth.dart';

class signUpBody extends StatefulWidget {
  final mainViewModel viewModel;
  signUpBody(this.viewModel);
  @override
  _signUpBodyState createState() => _signUpBodyState(viewModel);
}

class _signUpBodyState extends State<signUpBody> {
  final mainViewModel viewModel;
  _signUpBodyState(this.viewModel);

  String inputemail = "";
  String inputpassword = "";
  String inputconfirmpass = "";
  String emaillabel = "email";
  String passwordlabel = "password";
  String confirmpasslabel = "confirmpass";
  bool isEmailInput = false;
  bool isPasswordInput = false;
  bool isConfirmPassInput = false;

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
            loginTitle(context, "Sign up"),
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
                  onChanged: (value) {
                    isPasswordInput = (value.length != 0);
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
                  onChanged: (value) {
                    isConfirmPassInput = (value.length != 0);
                    if (isNotBlank(value)) inputconfirmpass = value;
                    print("confirmpass: $inputconfirmpass");
                    setState(() {});
                  },
                  cursorColor: Colors.lightBlue,
                  decoration: InputDecoration(
                    icon: Icon(Icons.security,),
                    labelText: confirmpasslabel,
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
                color: (isEmailInput && isPasswordInput && isConfirmPassInput) ? Colors.lightBlue: Colors.grey,
                child: TextButton(
                  child: Text("Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "defaultfont",
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (isEmailInput && isPasswordInput && isConfirmPassInput) {

                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}