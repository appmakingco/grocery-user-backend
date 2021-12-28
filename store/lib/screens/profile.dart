import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/auth.dart';
import 'package:store/controllers/profile.dart';
import 'package:store/screens/login.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static AuthController _auth = Get.put(AuthController());
  static ProfileController _profileCtrl = Get.put(ProfileController());

  var _profileImage = "https://picsum.photos/120/120";

  TextEditingController _nameCtrl =
      TextEditingController(text: _profileCtrl.userObj["name"]);
  TextEditingController _emailCtrl =
      TextEditingController(text: _profileCtrl.userObj["email"]);
  TextEditingController _mobileCtrl =
      TextEditingController(text: _profileCtrl.userObj["mobile"]);
  TextEditingController _addressCtrl =
      TextEditingController(text: _profileCtrl.userObj["address"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Store"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          width: double.infinity,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _profileCtrl.uploadProfileImage();
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_profileImage),
                  radius: 60,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Name",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _mobileCtrl,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Mobile Number",
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _addressCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Store Address",
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
                    _profileCtrl.updateStoreDetail({
                      "address": _addressCtrl.text,
                      "mobile": _mobileCtrl.text,
                      "email": _emailCtrl.text,
                      "name": _nameCtrl.text,
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _auth.logout();
                  Get.offAll(LoginScreen());
                },
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
