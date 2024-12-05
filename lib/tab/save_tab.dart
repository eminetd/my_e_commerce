// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/custom_action_bar.dart';

class SaveTab extends StatelessWidget {
  const SaveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Text('Action bar'),
          CustomActionBar(
            title: 'Saved',
            // hastitle: false,
            hasBackarrow: false,
          ),
        ],
      ),
    );
  }
}
