import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/home/components/product_card.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListProductsCard extends StatelessWidget {
  const ListProductsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          demo_product.length,
          (index) => Padding(
            padding: const EdgeInsets.only(
                right: defaultPadding, bottom: defaultPadding),
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
        ),
      ),
    );
  }
}
