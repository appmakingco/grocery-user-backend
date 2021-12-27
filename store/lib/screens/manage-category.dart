import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageCategoryScreen extends StatelessWidget {
  ManageCategoryScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Category"),
      ),
      body: Container(
        padding: EdgeInsets.all(32.0),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            TextField(
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
