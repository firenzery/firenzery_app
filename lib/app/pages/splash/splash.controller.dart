import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/user.model.dart';
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
// ignore: must_be_immutable

enum AuthState { idle, loading, unauthenticated, authenticated }

class SplashController extends ChangeNotifier {
  final ProductsViewModel productsViewModel =
      ProductsViewModel(ProductsService(ClientHttpSevice()));

  final CategoriesViewModel categoriesViewModel =
      CategoriesViewModel(CategoriesService(ClientHttpSevice()));

  final AdressViewModel adressViewModel =
      AdressViewModel(AdressService(ClientHttpSevice()));

  final UserViewModel userViewModel = UserViewModel(
      UserService(ClientHttpSevice()), SharedPreferencesService());

  final ILocaleStorage service = SharedPreferencesService();

  List<CategoryModel> allCategories = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> newArrivalProducts = [];
  bool? verify;
  List? values;

  String? email;
  String? password;

  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;
  ValueNotifier<UserModel> get userModel => userViewModel.userModel;

  AuthState state = AuthState.idle;

  verifyKeppConect() async {
    try {
      email = await service.getValue('email');
      password = await service.getValue('password');

      if (email != null && password != null) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  getValues() async {
    try {
      allCategories = await categoriesViewModel.getAllCategories();
      allProducts = await productsViewModel.getAllProducts();
      newArrivalProducts = await productsViewModel.getNewArrivalProducts();
      notifyListeners();
    } catch (error) {
      return error;
    }
  }

  navigateToPage() async {
    state = AuthState.loading;
    notifyListeners();

    values = await getValues();
    verify = await verifyKeppConect();

    if (verify!) {
      var idClient = await service.getValue('idClient');
      await userViewModel.getUser(idClient);
      await adressViewModel.getAdress(idClient);

      state = AuthState.authenticated;
      notifyListeners();
    } else {
      state = AuthState.unauthenticated;
      notifyListeners();
    }
  }
}
