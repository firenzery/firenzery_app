import 'package:firenzery/app/pages/payment_method/payment_method.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  late final PaymentMethodController controller;

  @override
  void initState() {
    controller = context.read<PaymentMethodController>();

    controller.getPaymentMethodValues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // const SizedBox(height: defaultPadding),
          // const Text('Pague na entrega',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: defaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(5)),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.paymentMethodValues.length,
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(3),
                    horizontal: getProportionateScreenWidth(3)),
                child: GestureDetector(
                  onTap: () {
                    controller.paymentSelected =
                        controller.paymentMethodValues[index];
                    Future.delayed(const Duration(milliseconds: 500),
                        () => Navigator.pop(context));
                  },
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: defaultPadding),
                        controller.paymentMethodValues[index].icon!,
                        const SizedBox(width: defaultPadding),
                        Text(
                          controller.paymentMethodValues[index].name!,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
