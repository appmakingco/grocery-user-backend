import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/tabs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 120,
                width: 120,
              ),
              SizedBox(height: 16),
              Text(
                "Sundar's shop",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Email Address",
                ),
              ),
              SizedBox(height: 16),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  labelText: "Password",
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: Text("LOGIN"),
                  onPressed: () {
                    Get.offAll(TabsScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
