import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/list_products/list_products.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'product_card.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  final List popularProductsList;

  const PopularProducts(this.popularProductsList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
          child: SectionTitle(
            title: "Popular",
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              popularProductsList.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: ProductCard(
                  title: popularProductsList[index].name,
                  image: popularProductsList[index].image,
                  price: popularProductsList[index].price,
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(product: popularProductsList[index]),
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
