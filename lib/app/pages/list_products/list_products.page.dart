import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/home/components/product_card.dart';
import 'package:firenzery/app/pages/list_products/components/list_products_card.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListProductsPage extends StatelessWidget {
  const ListProductsPage({Key? key, int? category, required this.title})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
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
              demo_product.length,
              (index) => Padding(
                padding: const EdgeInsets.only(
                    right: defaultPadding, top: defaultPadding),
                child: ProductCard(
                  title: demo_product[index].title,
                  image: demo_product[index].image,
                  price: demo_product[index].price,
                  bgColor: demo_product[index].bgColor,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(product: demo_product[index]),
                        ));
                  },
                ),
              ),
            )));
  }
}
