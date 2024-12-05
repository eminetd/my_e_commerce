// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/custom_action_bar.dart';
import 'package:my_e_commerece_app/firebase/firebase_auth.dart';
import 'package:my_e_commerece_app/product_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usertRef
                  .doc(_firebaseServices.getuserid())
                  .collection("cart")
                  .get(),
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
                          child: FutureBuilder(
                              future: _firebaseServices.productsRef
                                  .doc(document.id)
                                  .get(),
                              builder: (context, productsnap) {
                                if (productsnap.hasError) {
                                  return Container(
                                    child: Center(
                                      child: Text("${productsnap.error}"),
                                    ),
                                  );
                                }
                                if (productsnap.connectionState ==
                                    ConnectionState.done) {
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 24,
                                    ),
                                    child: Container(
                                      child: Text(
                                          "${productsnap.data?.get('name')}"),
                                    ),
                                  );
                                }
                                return Container();
                              }));
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
            hasBackarrow: true,
            title: 'Cart',
          )
        ],
      ),
    );
  }
}
