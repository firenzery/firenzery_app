import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:flutter/material.dart';

class ProductsViewModel {
  final productModel = ValueNotifier<ProductModel>(
      ProductModel(image: '', name: '', price: 0.00, type: 0));

  IProducts service;

  ProductsViewModel(this.service);

  getAllProducts() async {
    try {
      var response = await service.getAllProducts();
      List products =
          response.data.map((data) => ProductModel.fromJson(data)).toList();
      return products;
    } catch (error) {
      return error;
    }
  }
}
