// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/cart_page.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/firebase/firebase_auth.dart';

class CustomActionBar extends StatelessWidget {
  final String? title;
  final bool? hasBackarrow;
  final bool? hastitle;
  CustomActionBar({super.key, this.title, this.hasBackarrow, this.hastitle});

  FirebaseServices _firebaseServices = FirebaseServices();
  final CollectionReference _usertRef =
      FirebaseFirestore.instance.collection("Users");

  // final User? _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    bool _hasBackarrow = hasBackarrow ?? false;
    bool _hastitle = hastitle ?? true;

    final mediaQuery = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [colors.mywhite, colors.mywhite.withOpacity(0)],
        begin: Alignment(0, 0),
        end: Alignment(0, 1),
      )),
      padding: EdgeInsets.only(
        top: mediaQuery.viewPadding.top + 50,
        bottom: mediaQuery.viewPadding.bottom + 20,
        left: mediaQuery.viewPadding.left + 20,
        right: mediaQuery.viewPadding.right + 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackarrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          if (_hastitle)
            Text(
              title ?? "Action bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
            child: Container(
              height: mediaQuery.size.height * 0.05,
              width: mediaQuery.size.width * 0.3,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.myblack,
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder(
                stream: _usertRef
                    .doc(_firebaseServices.getuserid())
                    .collection("cart")
                    .snapshots(),
                builder: (context, snapshot) {
                  int? _totalitems = 0;

                  if (snapshot.connectionState == ConnectionState.active) {
                    List _document = snapshot.data!.docs;
                    _totalitems = _document.length;
                  }

                  return Text(
                    "${_totalitems}",
                    style: TextStyle(
                        fontSize: 18,
                        color: colors.mywhite,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
