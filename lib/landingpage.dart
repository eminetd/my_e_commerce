// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/homepage.dart';
import 'package:my_e_commerece_app/loginpage.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error:${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, streamsnapshot) {
                  if (streamsnapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error:${streamsnapshot.error}"),
                      ),
                    );
                  }
                  //connection state active -  do the  user login check inside
                  if (streamsnapshot.connectionState ==
                      ConnectionState.active) {
                    //get user
                    User? _user = streamsnapshot.data;
                    //user is null that because i am not logged in
                    if (_user == null) {
                      return LoginPage();
                    } else {
                      //user is logged in head to the home page
                      return HomePage();
                    }
                  }
                  //check the auth state loading
                  return Scaffold(
                    body: Center(
                      child: Text('checking authentication'),
                    ),
                  );
                });
          }
          return Scaffold(
            body: Center(
              child: Text(
                "Initialization app ",
                style: Constants.regularhHeading,
              ),
            ),
          );
        });
  }
}
