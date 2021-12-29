import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/category.dart';
import 'package:userapp/controllers/products.dart';
import 'package:userapp/custom-widgets/category-badge.dart';
import 'package:userapp/custom-widgets/product-card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryController _categoryCtrl = Get.put(CategoryController());
  ProductsController _productsCtrl = Get.put(ProductsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryCtrl.fetchCategories();
    _productsCtrl.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(autoPlay: true),
                items: [
                  Container(
                    child: Image.asset("assets/images/offers/1.png"),
                    padding: EdgeInsets.all(4),
                  ),
                  Container(
                    child: Image.asset("assets/images/offers/2.png"),
                    padding: EdgeInsets.all(4),
                  ),
                  Container(
                    child: Image.asset("assets/images/offers/3.png"),
                    padding: EdgeInsets.all(4),
                  )
                ],
              ),
            ),
            Container(
              height: 40,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categoryCtrl.categories.length,
                  itemBuilder: (bc, index) {
                    return CategoryBadge(
                      title: _categoryCtrl.categories[index]["title"],
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _productsCtrl.products.length,
                  itemBuilder: (bc, index) {
                    return ProductCard(
                      id: _productsCtrl.products[index]["id"],
                      imageURL: _productsCtrl.products[index]["imageURL"],
                      title: _productsCtrl.products[index]["title"],
                      price: _productsCtrl.products[index]["price"],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
