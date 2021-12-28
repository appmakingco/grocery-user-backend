import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store/screens/login.dart';
import 'package:store/screens/tabs.dart';

class ValidateScreen extends StatefulWidget {
  const ValidateScreen({Key? key}) : super(key: key);

  @override
  _ValidateScreenState createState() => _ValidateScreenState();
}

class _ValidateScreenState extends State<ValidateScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isUserLoggedin = false;

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        setState(() {
          _isUserLoggedin = true;
        });
      } else {
        setState(() {
          _isUserLoggedin = false;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    validate();
  }

  @override
  Widget build(BuildContext context) {
    return _isUserLoggedin ? TabsScreen() : LoginScreen();
  }
}
