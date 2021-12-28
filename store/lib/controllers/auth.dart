import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/controllers/profile.dart';
import 'package:store/screens/login.dart';
import 'package:store/screens/tabs.dart';

class AuthController extends GetxController {
  ProfileController _profileCtrl = Get.put(ProfileController());
  FirebaseAuth _auth = FirebaseAuth.instance;
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
        _profileCtrl.readStoreDetail();
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

  logout() {
    _auth.signOut().then((res) {
      Get.offAll(LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
