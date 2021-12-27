import 'package:flutter/material.dart';
import 'package:userapp/custom-widgets/cart-item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  List _cartItems = [
    {
      "imageURL": "assets/images/products/1.jpg",
      "title": "Carrot",
      "qty": 1,
      "price": 20.0,
      "total": 20.0,
    },
    {
      "imageURL": "assets/images/products/5.jpg",
      "title": "Raw Meat",
      "qty": 2,
      "price": 320.0,
      "total": 640.0,
    },
    {
      "imageURL": "assets/images/products/8.jpg",
      "title": "Orange",
      "qty": 1,
      "price": 170.0,
      "total": 170.0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (bc, index) {
                  return CartItem(
                    imageURL: _cartItems[index]["imageURL"],
                    title: _cartItems[index]["title"],
                    qty: _cartItems[index]["qty"],
                    price: _cartItems[index]["price"],
                    total: _cartItems[index]["total"],
                  );
                },
              ),
            ),
            ListTile(
              title: Text("Delivery Address"),
              subtitle: Text("13, Flutter Club, Earth - 0002"),
              trailing: TextButton(
                child: Text("Change"),
                onPressed: () {},
              ),
            ),
            ListTile(
              title: Text("Payment Method"),
              subtitle: Text("Cash On Delivery"),
              trailing: TextButton(
                child: Text("Change"),
                onPressed: () {},
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.0),
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: Text("Checkout (₹ 830)"),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
