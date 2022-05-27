import 'package:firenzery/app/interfaces/products.interface.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class ProductsViewModel {
  final productModel = ValueNotifier<ProductModel>(
      ProductModel(image: null, name: null, price: null, type: null));

  IProducts service;

  ProductsViewModel(this.service);

  getAllProducts() async {
    try {
      var response = await service.getAllProducts();

      List products = convert.jsonDecode(response.body);

      products = products.map((data) => ProductModel.fromJson(data)).toList();

      return products;
    } catch (error) {
      throw error;
    }
  }
}
