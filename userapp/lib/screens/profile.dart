import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/auth.dart';
import 'package:userapp/controllers/profile.dart';
import 'package:userapp/screens/welcome.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static AuthController _auth = Get.put(AuthController());
  static ProfileController _profileCtrl = Get.put(ProfileController());

  TextEditingController _nameCtrl =
      TextEditingController(text: _profileCtrl.userObj["name"]);
  TextEditingController _emailCtrl =
      TextEditingController(text: _profileCtrl.userObj["email"]);
  TextEditingController _mobileCtrl =
      TextEditingController(text: _profileCtrl.userObj["mobile"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _profileCtrl.uploadProfileImage();
                },
                child: Obx(
                  () => CircleAvatar(
                    backgroundImage:
                        NetworkImage(_profileCtrl.userObj["imageURL"]),
                    radius: 60,
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _nameCtrl,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Fullname"),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Email Address"),
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
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text("Save Changes"),
                  onPressed: () {
                    _profileCtrl.updateProfile({
                      "mobile": _mobileCtrl.text,
                      "email": _emailCtrl.text,
                      "name": _nameCtrl.text,
                    });
                  },
                ),
              ),
              Container(
                  child: TextButton(
                child: Text("Logout"),
                onPressed: () {
                  _auth.logout();
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
