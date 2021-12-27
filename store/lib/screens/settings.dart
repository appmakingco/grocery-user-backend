import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/profile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              title: Text("Sundar Shop"),
              subtitle: Text("234, SF St, 312"),
              trailing: TextButton(
                onPressed: () {
                  Get.to(ProfileScreen());
                },
                child: Text("Edit"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text("Notifications"),
              subtitle: Text("Manage Notifications"),
              trailing: Switch(
                onChanged: (i) {},
                value: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
