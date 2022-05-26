import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/splash/splash.page.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashController extends SplashPage {
  final ProductsViewModel productsViewModel;
  final CategoriesViewModel categoriesViewModel;

  ILocaleStorage service;
  List allCategories = [];
  List allProducts = [];
  bool? verify;
  List? values;

  String? email;
  String? password;

  SplashController(
      this.service, this.categoriesViewModel, this.productsViewModel);

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
    } catch (error) {
      return error;
    }
  }

  navigateToPage(context) async {
    values = await getValues();
    verify = await verifyKeppConect();

    await Future.delayed(Duration(milliseconds: 2000), () {});

    if (verify!) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NavigationBarComponent(allCategories, allProducts)),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(allCategories, allProducts),
          ));
    }
  }
}