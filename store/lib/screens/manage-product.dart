import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store/screens/login.dart';

class ManageProductScreen extends StatefulWidget {
  const ManageProductScreen({Key? key}) : super(key: key);

  @override
  _ManageProductScreenState createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var _categories = [];
  var _selectedId = "OzhC9yhKzN0wL10I8JBy";
  var imgURL = "https://picsum.photos/120/120";

  TextEditingController _titleCtrl = TextEditingController();
  TextEditingController _priceCtrl = TextEditingController();
  TextEditingController _descCtrl = TextEditingController();

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

  add() {
    _db.collection("products").add({
      "title": _titleCtrl.text,
      "price": _priceCtrl.text,
      "categoryId": _selectedId,
      "desc": _descCtrl.text
    }).then((r) {
      Get.back();
    }).catchError((e) {
      print(e);
    });
  }

  uploadImage() async {
    var picker = ImagePicker();
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile!.path.length != 0) {
      File image = File(pickedFile.path);
      FirebaseStorage _storage = FirebaseStorage.instance;
      var filePath = (DateTime.now().millisecondsSinceEpoch).toString();
      _storage
          .ref()
          .child("products")
          .child(filePath)
          .putFile(image)
          .then((res) {
        print(res);
        res.ref.getDownloadURL().then((url) {
          print("uploaded URL" + url);
          setState(() {
            imgURL = url;
          });
        });
      }).catchError((e) {
        print(e);
      });
    } else {
      print("No file picked");
    }
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Manage Product"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgURL),
                  radius: 60,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Product Title",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _priceCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Price",
                ),
              ),
              SizedBox(height: 12),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category"),
                    _categories.length != 0
                        ? DropdownButton(
                            value: _selectedId,
                            onChanged: (v) {
                              setState(() {
                                _selectedId = v.toString();
                              });
                            },
                            items: _categories.map((category) {
                              return DropdownMenuItem(
                                value: category["id"],
                                child: Text(category["title"]),
                              );
                            }).toList(),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Description",
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
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    add();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
