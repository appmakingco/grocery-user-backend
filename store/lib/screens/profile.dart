import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _mobileCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();

  logout() {
    _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }

  readStoreDetail() {
    _db.collection("settings").doc("store").get().then((res) {
      print(res);
      print(res.data());
      // we need to add ! to tell value is not null
      setState(() {
        _nameCtrl.text = res.data()!["name"];
        _emailCtrl.text = res.data()!["email"];
        _mobileCtrl.text = res.data()!["mobile"];
        _addressCtrl.text = res.data()!["address"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readStoreDetail();
  }

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
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                radius: 60,
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
                    Get.back();
                  },
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  logout();
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
