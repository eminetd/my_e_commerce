// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_e_commerece_app/color.dart';
import 'package:my_e_commerece_app/constants.dart';
import 'package:my_e_commerece_app/custom_action_bar.dart';
import 'package:my_e_commerece_app/firebase/firebase_auth.dart';
import 'package:my_e_commerece_app/tab/product_quantity.dart';

class ProductPage extends StatefulWidget {
  final String? productid;

  ProductPage({super.key, this.productid});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  // User? _user = FirebaseAuth.instance.currentUser;

  String _selectquantity = "0";

  Future<void> addtocart() {
    return _firebaseServices.usertRef
        .doc(_firebaseServices.getuserid())
        .collection("Cart")
        .doc(widget.productid)
        .set({"size": _selectquantity});
  }

  final SnackBar _snackbar = SnackBar(
    content: Text('Product added to the cart'),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
        child: Stack(
      children: [
        FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error:${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                // Map<String, dynamic> documentData = snapshot.data?.get();
                List imageList = snapshot.data?.get('images');
                List productQuantity = snapshot.data?.get('quantity');

                _selectquantity = productQuantity[0];
                return Scaffold(
                  body: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.viewInsets.vertical + 80,
                          horizontal: mediaQuery.viewInsets.horizontal + 50,
                        ),
                        child: Container(
                          height: mediaQuery.size.height * 0.4,
                          child: PageView(
                            children: [
                              for (var i = 0; i < imageList.length; i++)
                                Container(
                                  child: Image.network("${imageList[i]}"),
                                )
                              // Image.network(
                              //   "${snapshot.data?.get('images')[0]}"),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.viewInsets.vertical + 10,
                          horizontal: mediaQuery.viewInsets.horizontal + 50,
                        ),
                        child: Text(
                          '${snapshot.data?.get('name')}',
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.viewInsets.vertical + 10,
                          horizontal: mediaQuery.viewInsets.horizontal + 50,
                        ),
                        child: Text(
                          'Rs.${snapshot.data?.get('price')}',
                          style: TextStyle(
                            color: colors.myred,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.viewInsets.vertical + 10,
                          horizontal: mediaQuery.viewInsets.horizontal + 50,
                        ),
                        child: Text(
                          '${snapshot.data?.get('desc')}',
                          style: TextStyle(color: colors.myblack),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: mediaQuery.viewInsets.vertical + 10,
                          horizontal: mediaQuery.viewInsets.horizontal + 50,
                        ),
                        child: Text(
                          'Quantity',
                          style: TextStyle(color: colors.myblack),
                        ),
                      ),
                      PQuantity(
                        onselected: (size) {
                          _selectquantity = size;
                        },
                        productSize: productQuantity,
                      ),
                      Row(
                        children: [
                          Container(
                            height: mediaQuery.size.height * 0.07,
                            width: mediaQuery.size.width * 0.15,
                            decoration: BoxDecoration(
                              color: colors.mygrey,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            alignment: Alignment.center,
                            child: Image(
                              image: AssetImage('assets/save.png'),
                              height: 30,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await addtocart();
                                print('product added');
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                height: mediaQuery.size.height * 0.06,
                                width: mediaQuery.size.width * 0.0,
                                decoration: BoxDecoration(
                                    color: colors.myblack,
                                    borderRadius: BorderRadius.circular(10)),
                                alignment: Alignment.center,
                                child: Text(
                                  'Add to cart',
                                  style: TextStyle(
                                      color: colors.mywhite, fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
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
          hastitle: false,
        )
      ],
    ));
  }
}
