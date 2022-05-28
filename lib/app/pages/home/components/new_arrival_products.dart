import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/list_products/list_products.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';
import 'section_title.dart';

class NewArrivalProducts extends StatelessWidget {
  final List newProductsList;

  const NewArrivalProducts(this.newProductsList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "Novos Produtos",
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              newProductsList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: newProductsList[index].name,
                  image: newProductsList[index].image,
                  price: newProductsList[index].price,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(product: newProductsList[index]),
                        ));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
