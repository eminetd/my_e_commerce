// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';

class BottomTabs extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabPressed;
  BottomTabs({
    super.key,
    required this.selectedTab,
    this.tabPressed,
  });

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int? _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: colors.mygrey2,
          spreadRadius: 1,
          blurRadius: 10,
        )
      ], color: colors.mywhite, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomBtn(
            imagePath: 'assets/home.png',
            selected: _selectedTab == 0 ? true : false,
            onpressed: () {
              widget.tabPressed!(0);
            },
          ),
          BottomBtn(
            imagePath: 'assets/search.png',
            selected: _selectedTab == 1 ? true : false,
            onpressed: () {
              widget.tabPressed!(1);
            },
          ),
          BottomBtn(
            imagePath: 'assets/save.png',
            selected: _selectedTab == 2 ? true : false,
            onpressed: () {
              widget.tabPressed!(2);
            },
          ),
          BottomBtn(
            imagePath: 'assets/exit.png',
            selected: _selectedTab == 3 ? true : false,
            onpressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class BottomBtn extends StatelessWidget {
  final String? imagePath;
  final bool selected;
  final VoidCallback onpressed;
  BottomBtn(
      {super.key,
      this.imagePath,
      required this.selected,
      required this.onpressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ? true : false;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: _selected ? colors.myblack : colors.transparent),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).viewPadding.horizontal + 16,
          ),
          child: Image(
            fit: BoxFit.contain,
            color: _selected ? colors.myblack : colors.mygrey,
            image: AssetImage(imagePath ?? 'assets/home.png'),
          )),
    );
  }
}
