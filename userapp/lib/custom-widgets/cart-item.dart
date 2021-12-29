import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';

class CartItem extends StatelessWidget {
  CartController _cartCtrl = Get.put(CartController());

  String id;
  String imageURL;
  String title;
  int qty;
  double price;
  double total;

  CartItem({
    Key? key,
    required this.id,
    required this.imageURL,
    required this.title,
    required this.qty,
    required this.price,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              child: Image.network(
                "$imageURL",
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$title",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text("Qty $qty x ₹ $price"),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  RawMaterialButton(
                    fillColor: Colors.green,
                    elevation: 0,
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.add, color: Colors.white, size: 16),
                    onPressed: () {
                      _cartCtrl.addToCart({
                        "id": id,
                        "title": title,
                        "price": price,
                        "qty": 1,
                        "imageURL": imageURL
                      });
                    },
                    shape: CircleBorder(),
                    constraints: BoxConstraints(),
                  ),
                  Text("$qty"),
                  RawMaterialButton(
                    fillColor: Colors.green,
                    elevation: 0,
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.remove, color: Colors.white, size: 16),
                    onPressed: () {
                      _cartCtrl.removeFromCart({
                        "id": id,
                        "title": title,
                        "price": price,
                        "qty": 1,
                        "imageURL": imageURL
                      });
                    },
                    shape: CircleBorder(),
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              "₹ $total",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
