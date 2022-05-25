import 'dart:math';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';

class HomeController extends HomePage {
  final ProductsViewModel productsViewModel;
  final CategoriesViewModel categoriesViewModel;

  List products = [ProductModel(image: '', name: '', type: 0, price: 0.00)];

  List categories = [
    CategoryModel(
      icon: '',
      title: '',
      type: 0,
    )
  ];

  HomeController(this.productsViewModel, this.categoriesViewModel,
      this.categories, this.products)
      : super(categories, products);

  getFiveProductsbyCategory(allProducts, categoryId) {
    return allProducts
        .where((data) => data.type == categoryId)
        .toList()
        .getRange(0, allProducts.length >= 5 ? 5 : allProducts.length)
        .toList();
  }
}
