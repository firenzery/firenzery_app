import 'package:firenzery/app/models/product.model.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  double total = 0;

  calcMaxValue(List<ProductModel> productsList) {
    total = productsList.isNotEmpty
        ? productsList
            .map((data) => data.price! * data.quantity!)
            .reduce((value, element) => value + element)
            .toDouble()
        : 0.00;

    notifyListeners();
  }
}
