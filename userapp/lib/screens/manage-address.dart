import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: Image.asset(
                  "assets/images/map.png",
                  fit: BoxFit.cover,
                ),
                height: 200,
                width: double.infinity),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Tag (Eg. Home, Office)"),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Name"),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Mobile Number"),
                ),
                SizedBox(height: 12),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Address"),
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: InputBorder.none,
                      labelText: "Pincode"),
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
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
