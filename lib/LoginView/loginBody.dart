import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quiver/strings.dart';
import 'firebaseAuth.dart';
import 'passwordResetButton.dart';
import '/MainView/mainViewModel.dart';
import '/MainView/commonWidget.dart';

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
  String inputconfirmpass = "";
  bool isEmailInput = false;
  bool isPasswordInput = false;
  bool isConfirmPassInput = true;
  String title = "";
  String message = "";

  @override
  Widget build(BuildContext context) {
    if (!viewModel.isMoveSignup) isConfirmPassInput = true;
    final lang = Localizations.localeOf(context).languageCode;
    final customsize = (lang == "ja") ? 18.0: 24.0;
    final customfont = (lang == "ja") ? 'defaultfont': 'enAccent';
    return Center(
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0,),
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text((!viewModel.isMoveSignup) ?
              AppLocalizations.of(context)!.login:
              AppLocalizations.of(context)!.signup,
              style: customTextStyle(Colors.white, customsize, customfont),
            ),
            SizedBox(height: 30,),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    TextFormField(
                      style: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                      onChanged: (value) {
                        isEmailInput = (value.length != 0);
                        if (isNotBlank(value)) inputemail = value;
                        print("email: $inputemail, $isEmailInput");
                        setState(() {});
                      },
                      cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(
                        icon: Icon(CupertinoIcons.person_circle,),
                        labelText: AppLocalizations.of(context)!.email,
                        labelStyle: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                        contentPadding: EdgeInsets.all(0),
                        hintText: AppLocalizations.of(context)!.inputemailhint,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      autofocus: true,
                      obscureText: false,
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      style: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                      onChanged: (value) {
                        isPasswordInput = (value.length > 7 && value.length < 21);
                        if (isNotBlank(value)) inputpassword = value;
                        print("password: $inputpassword, $isPasswordInput");
                        setState(() {});
                      },
                      cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(
                        icon: Icon(CupertinoIcons.lock_circle,),
                        labelText: AppLocalizations.of(context)!.password,
                        labelStyle: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                        contentPadding: EdgeInsets.all(0),
                        hintText: AppLocalizations.of(context)!.inputpasswordhint,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      autofocus: false,
                      obscureText: true,
                    ),
                    if (viewModel.isMoveSignup) SizedBox(height: 10,),
                    if (viewModel.isMoveSignup) TextFormField(
                      style: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                      onChanged: (value) {
                        isConfirmPassInput = (value.length > 7 && value.length < 21 && value == inputpassword);
                        if (isNotBlank(value)) inputconfirmpass = value;
                        print("confirmpass: $inputconfirmpass, $isConfirmPassInput");
                        setState(() {});
                      },
                      cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(
                        icon: Icon(CupertinoIcons.lock_circle,),
                        labelText: AppLocalizations.of(context)!.confirmpass,
                        labelStyle: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                        contentPadding: EdgeInsets.all(0),
                        hintText: AppLocalizations.of(context)!.inputconfirmpasshint,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                      autofocus: false,
                      obscureText: true,
                    ),
                    SizedBox(height: 20,),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: (isEmailInput && isPasswordInput && isConfirmPassInput) ?
                                  Colors.lightBlue: Colors.grey,
                        child: TextButton(
                          child: Text((!viewModel.isMoveSignup) ?
                                   AppLocalizations.of(context)!.login:
                                   AppLocalizations.of(context)!.signup,
                            style: customTextStyle(Colors.white, 14, "defaultfont"),
                          ),
                          onPressed: () async {
                            if (isEmailInput && isPasswordInput && isConfirmPassInput) {
                              tryAuth(context, viewModel.isMoveSignup,
                                inputemail, inputpassword, inputconfirmpass,
                                {
                                  viewModel.stateLogin(),
                                }
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    if (!viewModel.isMoveSignup) TextButton(
                      child: Text(AppLocalizations.of(context)!.signup,
                        style: customTextStyle(Colors.lightBlue, 14, "defaultfont"),
                      ),
                      onPressed: () {
                        setState((){
                          viewModel.moveSignUp();
                          isConfirmPassInput = false;
                        });
                      },
                    ),
                    if (viewModel.isMoveSignup) SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            if (!viewModel.isMoveSignup) passwordResetButton(),
            Spacer(),
            if (!viewModel.isMoveSignup) ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                color: Colors.lightBlue,
                child: TextButton(
                  child: Text(AppLocalizations.of(context)!.usewithoutlogin,
                    style: customTextStyle(Colors.white, 14, "defaultfont"),
                  ),
                  onPressed: () => pushPage(context, "/h"),
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