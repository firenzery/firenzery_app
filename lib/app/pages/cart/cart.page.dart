import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
    ));
  }
}
