import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/screens/addresses.dart';
import 'package:userapp/screens/orders.dart';
import 'package:userapp/screens/profile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),
            title: Text("Sundaravel"),
            subtitle: Text("+9876543210"),
            trailing: TextButton(
              child: Text("Edit"),
              onPressed: () {
                Get.to(ProfileScreen());
              },
            ),
          ),
          ListTile(
            leading:
                Icon(Icons.notifications_active_outlined, color: Colors.green),
            title: Text("Notifications"),
            subtitle: Text("Turn on / off notifications"),
            trailing: Switch(
              value: true,
              onChanged: (i) {},
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(OrdersScreen());
            },
            leading: Icon(Icons.shopping_bag_outlined, color: Colors.green),
            title: Text("My Orders"),
            subtitle: Text("Manage My Orders"),
            trailing: Icon(Icons.arrow_forward),
          ),
          ListTile(
            onTap: () {
              Get.to(AddressesScreen());
            },
            leading: Icon(Icons.note_outlined, color: Colors.green),
            title: Text("My Addresses"),
            subtitle: Text("Manage delivery address"),
            trailing: Icon(Icons.arrow_forward),
          )
        ],
      ),
    );
  }
}
