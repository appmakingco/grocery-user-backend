import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/categories.dart';
import 'package:store/screens/manage-product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var _products = [];

  fetchProducts() {
    _db.collection("products").snapshots().listen((event) {
      _products.clear();
      var _tmp = [];
      event.docs.forEach((product) {
        _tmp.add({"id": product.id, ...product.data()});
      });
      setState(() {
        _products = _tmp;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(
                ManageProductScreen(
                  canEdit: false,
                  product: {},
                ),
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: TextButton(
                  onPressed: () {
                    Get.to(CategoriesScreen());
                  },
                  child: Text("Manage Categories")),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (bc, index) {
                  return ListTile(
                    title: Text("${_products[index]["title"]}"),
                    subtitle: Text("${_products[index]["price"]}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit_outlined),
                      onPressed: () {
                        Get.to(ManageProductScreen(
                          canEdit: true,
                          product: _products[index],
                        ));
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
