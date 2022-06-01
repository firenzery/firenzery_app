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
  final CategoriesViewModel categoriesViewModel =
      CategoriesViewModel(CategoriesService(ClientHttpSevice()));

  final ProductsViewModel productsViewModel =
      ProductsViewModel(ProductsService(ClientHttpSevice()));

  final AdressViewModel adressViewModel =
      AdressViewModel(AdressService(ClientHttpSevice()));

  List<CategoryModel> allCategories = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> newArrivalProducts = [];
  AdressModel adress = AdressModel();

  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  GetValuesState state = GetValuesState.idle;

  getValues(userId) async {
    state = GetValuesState.loading;
    notifyListeners();

    try {
      allCategories = await categoriesViewModel.getAllCategories();
      allProducts = await productsViewModel.getAllProducts();
      newArrivalProducts = await productsViewModel.getNewArrivalProducts();
      await adressViewModel.getAdress(userId);
      adress = adressModel.value;

      state = GetValuesState.success;
      notifyListeners();
    } catch (error) {
      state = GetValuesState.error;
      notifyListeners();
      return error;
    }
  }
}
