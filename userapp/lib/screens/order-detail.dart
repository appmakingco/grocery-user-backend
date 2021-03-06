import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  final Map orderObj;

  const OrderDetail({Key? key, required this.orderObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("#${orderObj["id"]} - ${orderObj["status"]}"),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Order"),
              subtitle: Text("${orderObj["dateString"]}"),
              trailing: Text("#${orderObj["id"]}"),
            ),
            ListTile(
              title: Text("Status"),
              subtitle: Text("${orderObj["status"]}"),
            ),
            ListTile(
              title: Text("Delivery"),
              subtitle: Text("${orderObj["deliveryAddress"]}"),
              trailing: Text("${orderObj["paymentMethod"]}"),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              padding: EdgeInsets.only(left: 12),
              child: Text(
                "CART ITEMS",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: orderObj["cartItems"].length,
                itemBuilder: (bc, index) {
                  return ListTile(
                    title: Text("${orderObj["cartItems"][index]["title"]}"),
                    subtitle: Text(
                        "qty: ${orderObj["cartItems"][index]["qty"]} x ₹ ${orderObj["cartItems"][index]["price"]}"),
                    trailing:
                        Text("₹ ${orderObj["cartItems"][index]["total"]}"),
                  );
                },
              ),
            ),
            Container(
              color: Colors.green,
              height: 80,
              padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "₹ ${orderObj["cartTotal"]}",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
