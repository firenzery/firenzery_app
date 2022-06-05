import 'dart:async';

import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/cart/components/check_out_card.dart';
import 'package:firenzery/app/pages/finalize_purchase/finalize_purchase.controller.dart';
import 'package:firenzery/app/pages/request_detail/request_detail.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FinalizePurchasePage extends StatefulWidget {
  const FinalizePurchasePage({Key? key}) : super(key: key);

  @override
  State<FinalizePurchasePage> createState() => _FinalizePurchasePageState();
}

class _FinalizePurchasePageState extends State<FinalizePurchasePage> {
  late final FinalizePurchaseController controller;
  late final CartController cartController;

  int _state = 0;

  @override
  void initState() {
    controller = context.read<FinalizePurchaseController>();
    cartController = Provider.of<CartController>(context, listen: false);
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
      bottomNavigationBar: Consumer<FinalizePurchaseController>(
        builder: (context, controller, Widget? child) => CheckoutCard(
          total: cartController.total,
          button: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor, shape: const StadiumBorder()),
            child: setUpButtonChild(),
            onPressed: () {
              setState(() {
                if (_state == 0) {
                  animateButton();
                }
              });
            },
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
        Future.delayed(
            const Duration(milliseconds: 1500),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RequestDetailPage())));
      });
    });
  }
}
