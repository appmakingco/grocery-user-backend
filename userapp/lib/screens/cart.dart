import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/cart.dart';
import 'package:userapp/custom-widgets/cart-item.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  CartController _cartCtrl = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Container(
            child: _cartCtrl.getProductCount() == 0
                ? Text("Cart is Empty")
                : Text("Cart - ${_cartCtrl.getProductCount()} Items"),
          ),
        ),
      ),
      body: Container(
        child: Obx(
          () => Container(
            child: _cartCtrl.getProductCount() == 0
                ? Center(child: Text("No Items In Cart"))
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _cartCtrl.cart.length,
                          itemBuilder: (bc, index) {
                            return CartItem(
                              id: _cartCtrl.cart[index]["id"],
                              imageURL: _cartCtrl.cart[index]["imageURL"],
                              title: _cartCtrl.cart[index]["title"],
                              qty: _cartCtrl.cart[index]["qty"],
                              price: _cartCtrl.cart[index]["price"],
                              total: _cartCtrl.cart[index]["total"],
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
                          child: Obx(
                            () => Text("Checkout (₹ ${_cartCtrl.getTotal()})"),
                          ),
                          onPressed: () {},
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
