import 'package:firenzery/app/models/product.model.dart';
import 'package:flutter/material.dart';

class ListProductsModel extends ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> products() => _products;

  ListProductsModel() {
    addProductsInList([]);
  }

  //function to check login
  addProductsInList(List<ProductModel> products) {
    _products = products;
    notifyListeners();
  }
}
