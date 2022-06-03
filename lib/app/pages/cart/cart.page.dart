import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';
import 'components/check_out_card.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartController controller;
  late final ProductsViewModel productsViewModel;

  @override
  void initState() {
    controller = context.read<CartController>();
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Consumer<ProductsViewModel>(
          builder: (context, value, Widget? child) => Body()),
      bottomNavigationBar: Consumer<CartController>(
          builder: (context, value, Widget? child) =>
              CheckoutCard(total: controller.total)),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      foregroundColor: Colors.black,
      title: const Text(
        "CARRINHO",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
