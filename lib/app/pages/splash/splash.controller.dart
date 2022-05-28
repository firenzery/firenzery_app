import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/list_categories.model.dart';
import 'package:firenzery/app/models/list_new_products.model.dart';
import 'package:firenzery/app/models/list_products.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/components/new_arrival_products.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/splash/splash.page.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SplashController extends SplashPage {
  final ProductsViewModel productsViewModel;
  final CategoriesViewModel categoriesViewModel;
  final AdressViewModel adressViewModel;
  final UserViewModel userViewModel;

  ILocaleStorage service;
  List<CategoryModel> allCategories = [];
  List<ProductModel> allProducts = [];
  List<ProductModel> newArrivalProducts = [];
  bool? verify;
  List? values;

  String? email;
  String? password;

  SplashController(this.service, this.categoriesViewModel,
      this.productsViewModel, this.adressViewModel, this.userViewModel);

  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;
  ValueNotifier<UserModel> get userModel => userViewModel.userModel;

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
    } catch (error) {
      return error;
    }
  }

  navigateToPage(context) async {
    values = await getValues();
    verify = await verifyKeppConect();

    var allProductsModel =
        Provider.of<ListProductsModel>(context, listen: false);
    var allCategoriesModel =
        Provider.of<ListCategoriesModel>(context, listen: false);
    var newProductsModel =
        Provider.of<ListNewProductsModel>(context, listen: false);

    allProductsModel.addProductsInList(allProducts);
    allCategoriesModel.addProductsInList(allCategories);
    newProductsModel.addProductsInList(newArrivalProducts);

    await Future.delayed(const Duration(milliseconds: 2000), () {});

    if (verify!) {
      var idClient = await service.getValue('idClient');
      await userViewModel.getUser(idClient);
      await adressViewModel.getAdress(idClient);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NavigationBarComponent(adressModel.value, userModel.value)),
      );
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }
}
