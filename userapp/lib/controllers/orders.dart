import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:userapp/controllers/cart.dart';
import 'dart:convert';

class OrderController extends GetxController {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  CartController _cartCtrl = Get.put(CartController());

  var orders = [].obs;

  @override
  onInit() {
    super.onInit();
    this.fetchOrders();
  }

  fetchOrders() {
    _db
        .collection("orders")
        .where("userId", isEqualTo: _auth.currentUser!.uid)
        .snapshots()
        .listen((res) {
      var _tmp = [];
      res.docs.forEach((order) {
        _tmp.add({"id": order.id, ...order.data()});
      });
      orders.assignAll(_tmp);
    });
  }

  createOrder() {
    var obj = {
      "userId": _auth.currentUser!.uid,
      "cart": _cartCtrl.cart.value,
      "deliveryAddress": _cartCtrl.selectedAddress.value,
      "paymentMode": _cartCtrl.paymentMode.value,
      "createdAt": FieldValue.serverTimestamp(),
      "cartTotal": _cartCtrl.getTotal(),
      "itemCount": _cartCtrl.getProductCount(),
      "status": "PROCESS"
    };

    _db.collection("orders").add(obj).then((res) {
      print("order placed");
      _cartCtrl.clearCart();
      Get.back();
    }).catchError((e) {
      print(e);
      print("error");
    });
  }
}
