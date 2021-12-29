import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:userapp/controllers/profile.dart';
import 'package:userapp/screens/login.dart';
import 'package:userapp/screens/tabs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  ProfileController _profileCtrl = Get.put(ProfileController());
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  var isUserLoggedIn = false.obs;

  GoogleSignIn _googleSignIn = GoogleSignIn();

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
      createAccountOnFireStore(userId, name, email);
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

  createAccountOnFireStore(userId, name, email) {
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
  }

  signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
        loginBehavior: LoginBehavior
            .nativeWithFallback); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken? accessToken = result.accessToken;

      AuthCredential credential =
          FacebookAuthProvider.credential(accessToken!.token);

      _auth.signInWithCredential(credential).then((res) {
        print(res);
        if (res.additionalUserInfo!.isNewUser) {
          createAccountOnFireStore(
            res.user!.uid,
            res.user!.displayName,
            res.user!.email,
          );
          isUserLoggedIn.value = true;
          Get.offAll(TabScreen());
        } else {
          isUserLoggedIn.value = true;
          Get.offAll(TabScreen());
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

  signInWithGoogle() async {
    // null-safty issue fixed
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    _auth.signInWithCredential(credential).then((res) {
      print(res);
      if (res.additionalUserInfo!.isNewUser) {
        createAccountOnFireStore(
          res.user!.uid,
          res.user!.displayName,
          res.user!.email,
        );
        isUserLoggedIn.value = true;
        Get.offAll(TabScreen());
      } else {
        isUserLoggedIn.value = true;
        Get.offAll(TabScreen());
      }
    }).catchError((e) {
      print(e);
    });
  }
}
