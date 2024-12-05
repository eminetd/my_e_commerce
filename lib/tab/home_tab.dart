// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/custom_action_bar.dart';
import 'package:my_e_commerece_app/firebase/firebase_auth.dart';
import 'package:my_e_commerece_app/product_page.dart';

class Hometab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  Hometab({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef.get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error:${snapshot.error}"),
                    ),
                  );
                }
                //collection data
                if (snapshot.connectionState == ConnectionState.done) {
                  //display the data
                  return ListView(
                    padding: EdgeInsets.only(
                      top: mediaQuery.viewInsets.top + 70,
                      bottom: mediaQuery.viewInsets.bottom + 10,
                    ),
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                productid: document.id,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            height: mediaQuery.size.height * 0.3,
                            margin: EdgeInsets.symmetric(
                              vertical: mediaQuery.viewInsets.vertical + 60,
                              horizontal: mediaQuery.viewInsets.horizontal + 60,
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: mediaQuery.size.height * 0.3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "${document.get('images')[0]}",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        document.get('name') ?? "Product Name",
                                        style: Constants.regularhHeading,
                                      ),
                                      Text(
                                        "Rs.${document.get('price')}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: colors.myred,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                            // Text("Name: ${document.get("name")}"),
                            ),
                      );
                    }).toList(),
                  );
                }
                //loading
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          CustomActionBar(
            title: 'Home',
            // hastitle: false,
            hasBackarrow: false,
          ),
        ],
      ),
    );
  }
}
