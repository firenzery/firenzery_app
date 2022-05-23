import 'dart:ffi';

import 'package:flutter/material.dart';

class ProductModel {
  final String image, title;
  final double price;
  final Color bgColor;

  ProductModel({
    required this.image,
    required this.title,
    required this.price,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}

List<ProductModel> demo_product = [
  ProductModel(
    image: "assets/images/coca_2L.png",
    title: "Coca Cola 2L",
    price: 10.00,
    bgColor: const Color(0xFFFEFBF9),
  ),
  ProductModel(
    image: "assets/images/sukita_laranja_2L.png",
    title: "Sukita Laranja 2L",
    price: 7.00,
  ),
  ProductModel(
    image: "assets/images/sukita_uva_2L.png",
    title: "Sukita Uva 2L",
    price: 7.00,
    bgColor: const Color(0xFFF8FEFB),
  ),
  ProductModel(
    image: "assets/images/soda_2L.png",
    title: "Soda 2L",
    price: 7.50,
    bgColor: const Color(0xFFEEEEED),
  ),
];
