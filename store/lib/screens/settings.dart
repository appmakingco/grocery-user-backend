import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/profile.dart';
import 'package:store/screens/profile.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  ProfileController _profileCtrl = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: ListView(
          children: [
            Obx(
              () => ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    _profileCtrl.userObj["imageURL"],
                  ),
                ),
                title: Text("${_profileCtrl.userObj["name"]}"),
                subtitle: Text("${_profileCtrl.userObj["address"]}"),
                trailing: TextButton(
                  onPressed: () {
                    Get.to(ProfileScreen());
                  },
                  child: Text("Edit"),
                ),
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
