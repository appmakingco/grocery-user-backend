import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/category.dart';
import 'package:store/screens/manage-category.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  CategoryController _categoryCtrl = Get.put(CategoryController());

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
        child: Obx(
          () => ListView.builder(
            itemCount: _categoryCtrl.categories.length,
            itemBuilder: (bc, index) {
              return ListTile(
                title: Text("${_categoryCtrl.categories[index]["title"]}"),
                trailing: Icon(Icons.edit_outlined),
                onTap: () {
                  Get.to(ManageCategoryScreen(
                    canEdit: true,
                    category: _categoryCtrl.categories[index],
                  ));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
