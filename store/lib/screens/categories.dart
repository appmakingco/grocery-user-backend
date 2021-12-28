import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/manage-category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var _categories = [];

  fetchCategories() {
    _db.collection("categories").snapshots().listen((event) {
      _categories.clear();
      var tmp = [];
      event.docs.forEach((element) {
        tmp.add({"id": element.id, "title": element.data()["title"]});
      });
      setState(() {
        _categories = tmp;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(ManageCategoryScreen(
                canEdit: false,
                category: {},
              ));
            },
          )
        ],
      ),
      body: Container(
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (bc, index) {
            return ListTile(
              title: Text("${_categories[index]["title"]}"),
              trailing: Icon(Icons.edit_outlined),
              onTap: () {
                Get.to(ManageCategoryScreen(
                  canEdit: true,
                  category: _categories[index],
                ));
              },
            );
          },
        ),
      ),
    );
  }
}
