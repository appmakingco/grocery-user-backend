import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/login.dart';

class ManageProductScreen extends StatelessWidget {
  ManageProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Product"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
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
                labelText: "Product Title",
              ),
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
                labelText: "Price",
              ),
            ),
            SizedBox(height: 12),
            TextField(
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
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
