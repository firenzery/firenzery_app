import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ProductsViewModel extends ChangeNotifier {
  final IProducts service = ProductsService(ClientHttpSevice());

  List<ProductModel> products = [];
  List<ProductModel> cartProducts = [];
  List<ProductModel> newArrivedProducts = [];

  refreshValues() {
    notifyListeners();
  }

  clearCart() {
    cartProducts = [];
    notifyListeners();
  }

  addProductCart(ProductModel product) {
    if (!cartProducts.any((data) => data.idProduct == product.idProduct)) {
      cartProducts.add(product);
      notifyListeners();
    }
  }

  getAllProducts() async {
    try {
      var response = await service.getAllProducts();

      List productsBody = convert.jsonDecode(response.body);

      products =
          productsBody.map((data) => ProductModel.fromJson(data)).toList();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  getNewArrivalProducts() async {
    try {
      var response = await service.getNewArrivedProducts();

      List newArrivedProductsBody = convert.jsonDecode(response.body);

      newArrivedProducts = newArrivedProductsBody
          .map((data) => ProductModel.fromJson(data))
          .toList();

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
