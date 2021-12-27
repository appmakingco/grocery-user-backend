import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/screens/manage-address.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Addresses"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Home"),
            subtitle: Text("12, Flutter Club, Earth 091234"),
            trailing: IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                Get.to(ManageAddressScreen());
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(ManageAddressScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
