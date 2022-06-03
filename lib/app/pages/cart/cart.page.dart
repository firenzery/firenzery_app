import 'dart:ffi';

import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/cart/components/card.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        title: Text(
          'Carrinho',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
              Consumer<ProductsViewModel>(
                  builder: (context, productsViewModel, Widget? child) =>
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: productsViewModel.cartProducts.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(defaultPadding / 2),
                          child: CardCart(
                              title:
                                  productsViewModel.cartProducts[index].name!,
                              image:
                                  productsViewModel.cartProducts[index].image!,
                              price:
                                  productsViewModel.cartProducts[index].price!,
                              quantity: productsViewModel
                                  .cartProducts[index].quantity!,
                              quantityChange: (value) {
                                setState(() {
                                  if (value == '0') {
                                    productsViewModel.cartProducts.remove(
                                        productsViewModel.cartProducts[index]);
                                  } else {
                                    productsViewModel
                                            .cartProducts[index].quantity =
                                        int.parse(value.replaceAll(',', ''));
                                  }

                                  controller.calcMaxValue(
                                      productsViewModel.cartProducts);
                                });
                              }),
                        ),
                      )),
              Consumer<CartController>(
                  builder: (context, controller, Widget? child) =>
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Text('Total: R\$${controller.total}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ])),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  width: 200,
                  height: 48,
                  child: Consumer<CartController>(builder:
                      (BuildContext context, controller, Widget? child) {
                    return ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor, shape: const StadiumBorder()),
                      child: const Text("Finalizar"),
                    );
                  })),
            ]),
          ),
        ],
      ),
    );
  }
}
