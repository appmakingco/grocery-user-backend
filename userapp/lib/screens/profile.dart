import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/screens/welcome.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
              radius: 60,
            ),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Fullname"),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address"),
            ),
            SizedBox(height: 12),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Password"),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                child: Text("Save Changes"),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            Container(
                child: TextButton(
              child: Text("Logout"),
              onPressed: () {
                Get.offAll(WelcomeScreen());
              },
            )),
          ],
        ),
      ),
    );
  }
}
