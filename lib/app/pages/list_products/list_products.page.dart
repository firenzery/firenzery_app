import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/home/components/product_card.dart';
import 'package:firenzery/app/pages/list_products/list_products.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class ListProductsPage extends StatelessWidget {
  final List allProducts;
  final int? categoryId;
  final String title;

  const ListProductsPage(
      {required this.allProducts, this.categoryId, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = ListProductsController(
        allProducts: allProducts, categoryId: categoryId, title: title);

    List productsList = categoryId != null
        ? controller.getProductsbyCategory(categoryId!)
        : allProducts;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: const BackButton(color: Colors.black),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              productsList.length,
              (index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 4),
                child: ProductCard(
                  title: productsList[index].name,
                  image: productsList[index].image,
                  price: productsList[index].price,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(product: productsList[index]),
                        ));
                  },
                ),
              ),
            )));
  }
}
