// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? loginEmail = "";
  String? loginPassword = "";
  //focusnode
  FocusNode? _passwordFocusNode;
  Future<void> _alertdialog(String? error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error!),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: colors.myblack),
                child: Text("close dialog"),
              )
            ],
          );
        });
  }

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmail.toString(),
        password: loginPassword.toString(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        return 'the password provided is too weak';
      } else if (e.code == 'email-already - in -use') {
        return 'the account is already exists for that mail';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void submitForm() async {
    //run create account
    String? logInFeedback = await _loginAccount();
    //string is not null we arre getting error here
    if (logInFeedback != null) {
      _alertdialog(logInFeedback);
    }
  }

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: mediaQuery.viewPadding.top + 20),
                child: Text(
                  "Welcome !! \nLogin to your account",
                  style: Constants.boldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      height: mediaQuery.size.height * 0.07,
                      margin: EdgeInsets.symmetric(
                        horizontal: mediaQuery.viewPadding.horizontal + 10,
                        // vertical: mediaQuery.viewPadding.vertical + 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colors.mygrey2,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          loginEmail = value;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.viewPadding.horizontal + 20,
                            // vertical: mediaQuery.viewPadding.vertical + 1,
                          ),
                          hintText: 'Email',
                        ),
                        style: Constants.darkHeading,
                        onSubmitted: (value) {
                          _passwordFocusNode?.requestFocus();
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Container(
                      height: mediaQuery.size.height * 0.07,
                      margin: EdgeInsets.symmetric(
                        horizontal: mediaQuery.viewPadding.horizontal + 10,
                        vertical: mediaQuery.viewPadding.vertical + 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: colors.mygrey2,
                      ),
                      child: TextField(
                        focusNode: _passwordFocusNode,
                        onChanged: (value) {
                          loginPassword = value;
                        },
                        onSubmitted: (value) {
                          submitForm();
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: mediaQuery.viewPadding.horizontal + 20,
                            // vertical: mediaQuery.viewPadding.vertical + 12,
                          ),
                          hintText: 'Password',
                        ),
                        style: Constants.darkHeading,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  submitForm();
                },
                child: Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
                  decoration: BoxDecoration(
                    color: colors.myblack,
                    border: Border.all(color: colors.myblack),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: colors.mywhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Container(
                  height: mediaQuery.size.height * 0.06,
                  width: mediaQuery.size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.myblack),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Create Account",
                      style: Constants.regularhHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
