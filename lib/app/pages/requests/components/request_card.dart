import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/pages/requests/requests.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RequestCard extends StatelessWidget {
  final SaleModel sale;
  final press;

  const RequestCard({required this.sale, required this.press, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RequestController controller = RequestController();

    return GestureDetector(
      onTap: press,
      child: Container(
        height: getProportionateScreenWidth(120),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(defaultPadding / 1.5),
              vertical: getProportionateScreenHeight(defaultPadding / 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: getProportionateScreenWidth(10),
                  decoration: BoxDecoration(
                    color: controller.setColorState(sale.state!),
                    borderRadius: BorderRadius.circular(15),
                  )),
              Text(
                '#${sale.idSale!}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text.rich(
                TextSpan(
                  text: "Forma de Pagamento: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  children: [
                    TextSpan(
                        text: controller.setPayment(sale.payment!),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14)),
                  ],
                ),
              ),
              Text.rich(
                TextSpan(
                  text: "Total: ",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                  children: [
                    TextSpan(
                        text: "R\$${sale.total}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
