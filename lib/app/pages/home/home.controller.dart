import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/login/login.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';

enum GetValuesState { idle, error, success, loading }

// ignore: must_be_immutable
class HomeController extends ChangeNotifier {
  GetValuesState state = GetValuesState.idle;

  List<ProductModel> searchList = [];

  refreshValues() {
    notifyListeners();
  }

  searchItens(String search, ProductsViewModel productsViewModel) {
    searchList = productsViewModel.products
        .where((product) =>
            product.name!.toLowerCase().contains(search.toLowerCase()))
        .toList();
    notifyListeners();
  }

  getValues(
      int userId,
      CategoriesViewModel categoriesViewModel,
      ProductsViewModel productsViewModel,
      AdressViewModel adressViewModel) async {
    state = GetValuesState.loading;
    notifyListeners();

    try {
      await categoriesViewModel.getAllCategories();
      await productsViewModel.getAllProducts();
      await productsViewModel.getPopularProducts();
      await adressViewModel.getAdress(userId);
      state = GetValuesState.success;
      notifyListeners();
    } catch (error) {
      state = GetValuesState.error;
      notifyListeners();
      return error;
    }
  }
}
