import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCategoryScreen extends StatelessWidget {
  bool canEdit = false;
  var category = {};
  TextEditingController _titleCtrl = TextEditingController();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  ManageCategoryScreen({
    Key? key,
    required this.canEdit,
    required this.category,
  }) : super(key: key) {
    if (canEdit) _titleCtrl.text = category["title"];
  }

  update() {
    _db.collection("categories").doc(category["id"]).update({
      "title": _titleCtrl.text,
    }).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  add() {
    _db.collection("categories").add({
      "title": _titleCtrl.text,
    }).then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  delete() {
    _db.collection("categories").doc(category["id"]).delete().then((value) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${canEdit ? 'Edit' : 'Add'} Category"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
              controller: _titleCtrl,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Category Name",
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.green,
                ),
                child: Text(
                  "${canEdit ? 'UPDATE' : 'ADD'}",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  canEdit ? update() : add();
                },
              ),
            ),
            canEdit
                ? TextButton(
                    child: Text(
                      "Delete",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      delete();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
