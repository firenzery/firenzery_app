import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/home/components/product_card.dart';
import 'package:firenzery/app/pages/list_products/list_products.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class ListProductsPage extends StatelessWidget {
  final List allProducts;
  final int categoryId;
  final String title;

  const ListProductsPage(this.allProducts, this.categoryId, this.title,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ListProductsController(allProducts, categoryId, title);

    List productsList = controller.getProductsbyCategory(categoryId);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: const BackButton(color: Colors.black),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(defaultPadding),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(
                  productsList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                        right: defaultPadding, top: defaultPadding),
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
                ))));
  }
}
