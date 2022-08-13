import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/models/popular-products-response.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/home/components/popular_products.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ProductsViewModel extends ChangeNotifier {
  final IProducts service = ProductsService(ClientHttpSevice());

  List<ProductModel> products = [];
  List<ProductModel> cartProducts = [];
  List<ProductModel> newArrivedProducts = [];
  List<ProductModel> popularProducts = [];

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

      newArrivedProducts = products;
      newArrivedProducts.sort((a, b) => b.datetime!.compareTo(a.datetime!));
      newArrivedProducts = newArrivedProducts.getRange(0, 5).toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  getPopularProducts() async {
    try {
      var response = await this.service.getPopularProducts();

      List popularProductsBody = convert.jsonDecode(response.body);

      popularProductsBody = popularProductsBody
          .map((data) => PopularProductsResponse.fromJson(data))
          .toList();

      popularProducts = products
          .where((product) => popularProductsBody
              .map((e) => e.idProduct)
              .toList()
              .contains(product.idProduct))
          .toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
