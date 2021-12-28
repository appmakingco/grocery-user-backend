import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  var products = [].obs;

  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  fetchProducts() {
    _db.collection("products").snapshots().listen((event) {
      products.clear();
      var _tmp = [];
      event.docs.forEach((product) {
        _tmp.add({"id": product.id, ...product.data()});
      });
      products.assignAll(_tmp);
    });
  }
}
