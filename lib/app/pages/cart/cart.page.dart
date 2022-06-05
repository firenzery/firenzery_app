import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/cart/components/cart_card.dart';
import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/finalize_purchase/finalize_purchase.page.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
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

    productsViewModel.addListener(() {
      controller.calcMaxValue(productsViewModel.cartProducts);
    });

    Future.delayed(const Duration(milliseconds: 500),
        () => controller.calcMaxValue(productsViewModel.cartProducts));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
        title: const Text(
          "Carrinho",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(5)),
        child: ListView.builder(
            itemCount: productsViewModel.cartProducts.length,
            itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenWidth(3)),
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
                        press: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      product: productsViewModel
                                          .cartProducts[index]),
                                ))
                            .then(
                                (value) => productsViewModel.refreshValues())),
                  ),
                ))),
      ),
      bottomNavigationBar: Consumer<CartController>(
        builder: (context, value, Widget? child) => CheckoutCard(
          total: controller.total,
          button: ElevatedButton(
            onPressed: productsViewModel.cartProducts.isNotEmpty
                ? () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FinalizePurchasePage()))
                : null,
            style: ElevatedButton.styleFrom(
                primary: primaryColor, shape: const StadiumBorder()),
            child: const Text("Finalizar"),
          ),
        ),
      ),
    );
  }
}
