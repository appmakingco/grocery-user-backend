import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/tabs.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  login() {
    var emailText = (_emailCtrl.text).trim().toLowerCase();
    var passwordText = _passwordCtrl.text;
    _auth
        .signInWithEmailAndPassword(email: emailText, password: passwordText)
        .then((res) {
      print(res);
      Get.offAll(TabsScreen());
    }).catchError((e) {
      print(e);
      Get.showSnackbar(
        GetBar(
          message: "${e.toString()}",
          duration: Duration(
            seconds: 2,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: InputBorder.none,
                    labelText: "Email Address",
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordCtrl,
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
                      login();
                      // Get.offAll(TabsScreen());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
