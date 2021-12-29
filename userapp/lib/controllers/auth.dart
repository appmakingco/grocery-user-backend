import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:userapp/controllers/profile.dart';
import 'package:userapp/screens/login.dart';
import 'package:userapp/screens/tabs.dart';

class AuthController extends GetxController {
  ProfileController _profileCtrl = Get.put(ProfileController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var isUserLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  validate() {
    _auth.authStateChanges().listen((user) {
      print(user);
      if (user != null) {
        isUserLoggedIn.value = true;
        _profileCtrl.getUserDetail(user.uid);
      } else {
        isUserLoggedIn.value = false;
      }
    });
  }

  login(email, password) {
    email = (email).trim().toLowerCase();

    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((res) {
      print(res);
      Get.offAll(TabScreen());
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

  register(name, email, password) {
    email = (email).trim().toLowerCase();
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((res) {
      var userId = res.user!.uid;
      _db.collection("accounts").doc(userId).set({
        "name": name,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
        "imageURL": "http://placehold.it/120x120"
      }).then((value) {
        Get.offAll(TabScreen());
      }).catchError((e) {
        print(e);
      });
    }).catchError((e) {
      print(e);
    });
  }

  logout() {
    _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
