import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:quantity_input/quantity_input.dart';

class CardCart extends StatelessWidget {
  const CardCart(
      {Key? key,
      required this.image,
      required this.title,
      required this.price,
      required this.quantity,
      required this.quantityChange})
      : super(key: key);
  final String image, title;
  final int quantity;
  final double price;
  final quantityChange;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        padding: const EdgeInsets.all(defaultPadding / 2),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            height: 125,
            width: 125,
            decoration: const BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(defaultBorderRadius)),
            ),
            child: Image.network(
              image,
              height: 132,
              width: 132,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(title,
                    style: const TextStyle(color: Colors.black, fontSize: 16)),
              ),
              Row(
                children: [
                  QuantityInput(
                    inputWidth: 30,
                    acceptsZero: true,
                    buttonColor: primaryColor,
                    value: quantity,
                    onChanged: quantityChange,
                  ),
                  const SizedBox(width: defaultPadding * 2),
                  Text(
                    "R\$$price",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ],
          ),
        ]));
  }
}
