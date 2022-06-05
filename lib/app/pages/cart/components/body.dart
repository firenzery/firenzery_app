import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/cart/cart.page.dart';
import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late final CartController controller;
  late final ProductsViewModel productsViewModel;
  late double total;

  @override
  void initState() {
    controller = context.read<CartController>();
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 500),
        () => controller.calcMaxValue(productsViewModel.cartProducts));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: ListView.builder(
          itemCount: productsViewModel.cartProducts.length,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: Consumer<ProductsViewModel>(
                builder: (context, productsViewModel, Widget? child) =>
                    Dismissible(
                  key: Key(productsViewModel.cartProducts[index].idProduct
                      .toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      productsViewModel.cartProducts.removeAt(index);
                      controller.calcMaxValue(productsViewModel.cartProducts);
                    });
                  },
                  background: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE6E6),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        SvgPicture.asset("assets/icons/Trash.svg"),
                      ],
                    ),
                  ),
                  child: CartCard(
                    product: productsViewModel.cartProducts[index],
                    press: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                product: productsViewModel.cartProducts[index]),
                          )).then((value) => productsViewModel.refreshValues());
                    },
                  ),
                ),
              ))),
    );
  }
}
