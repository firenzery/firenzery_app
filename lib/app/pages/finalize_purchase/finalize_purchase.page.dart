import 'dart:async';

import 'package:firenzery/app/pages/address/adress.page.dart';
import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/cart/components/cart_card.dart';
import 'package:firenzery/app/pages/cart/components/check_out_card.dart';
import 'package:firenzery/app/pages/details/details.page.dart';
import 'package:firenzery/app/pages/finalize_purchase/finalize_purchase.controller.dart';
import 'package:firenzery/app/pages/payment_method/payment_method.controller.dart';
import 'package:firenzery/app/pages/payment_method/payment_method.page.dart';
import 'package:firenzery/app/pages/request_detail/request_detail.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class FinalizePurchasePage extends StatefulWidget {
  const FinalizePurchasePage({Key? key}) : super(key: key);

  @override
  State<FinalizePurchasePage> createState() => _FinalizePurchasePageState();
}

class _FinalizePurchasePageState extends State<FinalizePurchasePage> {
  late final FinalizePurchaseController controller;
  late final CartController cartController;
  late final ProductsViewModel productsViewModel;
  late final AdressViewModel adressViewModel;
  late final PaymentMethodController paymentMethodController;

  int _state = 0;

  @override
  void initState() {
    controller = context.read<FinalizePurchaseController>();
    cartController = Provider.of<CartController>(context, listen: false);
    productsViewModel = Provider.of<ProductsViewModel>(context, listen: false);
    adressViewModel = Provider.of<AdressViewModel>(context, listen: false);
    paymentMethodController =
        Provider.of<PaymentMethodController>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Finalizar'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding, horizontal: defaultPadding / 1.5),
        child: Column(
          children: [
            Container(
              height: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: productsViewModel.cartProducts.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: getProportionateScreenWidth(3)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: AspectRatio(
                          aspectRatio: 0.88,
                          child: Image.network(
                            productsViewModel.cartProducts[index].image!,
                            height: 132,
                            width: 132,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productsViewModel.cartProducts[index].name!,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          const SizedBox(height: 10),
                          Text.rich(
                            TextSpan(
                              text:
                                  "\$${productsViewModel.cartProducts[index].price}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                              children: [
                                TextSpan(
                                    text:
                                        "  x${productsViewModel.cartProducts[index].quantity}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Container(
              height: getProportionateScreenWidth(75),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Metodo de Pagamento',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: getProportionateScreenWidth(5)),
                        Consumer<PaymentMethodController>(
                          builder: (context, paymentMethodController,
                                  Widget? child) =>
                              Text.rich(
                            TextSpan(
                              text: paymentMethodController.paymentSelected !=
                                      null
                                  ? paymentMethodController
                                      .paymentSelected!.name
                                  : 'Selecione o metodo de pagamento',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PaymentMethodPage())).then(
                            (value) => paymentMethodController.refreshValues()),
                        icon: const Icon(Icons.arrow_forward_ios_outlined))
                  ],
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Container(
              height: getProportionateScreenWidth(75),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Endereço',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: getProportionateScreenWidth(5)),
                        Consumer<AdressViewModel>(
                          builder: (context, adressViewModel, Widget? child) =>
                              Text.rich(
                            TextSpan(
                              text: adressViewModel.adressModel.idAdress != null
                                  ? "${adressViewModel.adressModel.apartment}${adressViewModel.adressModel.block} GRUPO ${adressViewModel.adressModel.group}"
                                  : 'Endereço aqui',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    IconButton(
                        onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AdressPage()))
                            .then((value) => adressViewModel.refreshValues()),
                        icon: const Icon(Icons.arrow_forward_ios_outlined))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Consumer<FinalizePurchaseController>(
        builder: (context, controller, Widget? child) => CheckoutCard(
          total: cartController.total,
          button: Consumer<PaymentMethodController>(
            builder: (context, paymentMethodController, child) =>
                Consumer<AdressViewModel>(
              builder: (context, adressViewModel, Widget? child) =>
                  ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: primaryColor, shape: const StadiumBorder()),
                child: setUpButtonChild(),
                onPressed: adressViewModel.adressModel.idAdress != null &&
                        paymentMethodController.paymentSelected != null
                    ? () {
                        setState(() {
                          if (_state == 0) {
                            animateButton();
                          }
                        });
                      }
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        "Fazer pedido",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return const Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(const Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
        productsViewModel.clearCart();
        Future.delayed(
            const Duration(milliseconds: 500),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestDetailPage())));
      });
    });
  }
}
