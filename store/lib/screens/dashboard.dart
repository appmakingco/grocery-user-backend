import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/orders.dart';
import 'package:store/custom-widgets/dashboard-card.dart';
import 'package:store/screens/order-detail.dart';
import 'package:intl/intl.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({Key? key}) : super(key: key);
  OrderController _orderCtrl = Get.put(OrderController());

  toDateString(timestamp) {
    var date = DateTime.parse(timestamp.toDate().toString());
    var formatter = DateFormat("dd-MMM-yyyy");
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DashBoardCard(
                    title: "On Process",
                    value: (_orderCtrl.orderProcessingCount.value).toDouble(),
                  ),
                  DashBoardCard(
                    title: "Completed",
                    value: (_orderCtrl.orderCompletedCount.value).toDouble(),
                  ),
                  DashBoardCard(
                    title: "Cancelled",
                    value: (_orderCtrl.orderCancelledCount.value).toDouble(),
                  ),
                ],
              ),
              Row(
                children: [
                  DashBoardCard(
                    title: "Total Orders",
                    value: (_orderCtrl.totalOrders.value).toDouble(),
                  ),
                  DashBoardCard(
                    title: "Total Revenue",
                    value: (_orderCtrl.totalRevenue.value).toDouble(),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "ORDERS",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: _orderCtrl.orders.length,
                    itemBuilder: (bc, index) {
                      return ListTile(
                        title: Text("# ${_orderCtrl.orders[index]["id"]}"),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${toDateString(_orderCtrl.orders[index]["createdAt"])}"),
                            Text(
                                "${_orderCtrl.orders[index]["itemCount"]} Items - ₹ ${_orderCtrl.orders[index]["cartTotal"]}"),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Text("${_orderCtrl.orders[index]["status"]}"),
                        onTap: () {
                          Get.to(
                            OrderDetail(
                              orderObj: _orderCtrl.orders[index],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
