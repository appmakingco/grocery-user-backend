import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  String imageURL;
  String title;
  double price;

  ProductCard({
    Key? key,
    required this.imageURL,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  color: Colors.black.withOpacity(0.4),
                  padding: EdgeInsets.only(left: 4, right: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$title",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹ $price",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ElevatedButton(
                          child: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
