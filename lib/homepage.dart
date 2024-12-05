// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/bottom_tabs.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/firebase/firebase_auth.dart';
import 'package:my_e_commerece_app/tab/home_tab.dart';
import 'package:my_e_commerece_app/tab/save_tab.dart';
import 'package:my_e_commerece_app/tab/search_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  PageController? _tabsPagecontroller;
  int? _selectedTab = 0;

  @override
  void initState() {
    print("User Id:${_firebaseServices.getuserid()}");
    _tabsPagecontroller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPagecontroller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: PageView(
          controller: _tabsPagecontroller,
          onPageChanged: (num) {
            setState(() {
              _selectedTab = num;
            });
          },
          children: [
            Hometab(),
            SearchTab(),
            SaveTab(),
          ],
        )),
        BottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            setState(() {
              _tabsPagecontroller?.animateToPage(
                num,
                duration: Duration(microseconds: 300),
                curve: Curves.easeOutCubic,
              );
            });
          },
        )
      ],
    ));
  }
}
