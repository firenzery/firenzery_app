import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:flutter/material.dart';

import '../../models/login.model.dart';
import '../../viewmodels/user.viewmodel.dart';

import '../home/home.page.dart';
import 'components/alertDialog.dart';

class LoginController extends LoginPage {
  final UserViewModel viewModel;
  final ProductsViewModel productsViewModel;
  final CategoriesViewModel categoriesViewModel;

  List allProducts = [ProductModel(image: '', name: '', type: 0, price: 0.00)];

  List allCategories = [
    CategoryModel(
      icon: '',
      title: '',
      type: 0,
    )
  ];

  LoginController(
      this.viewModel, this.productsViewModel, this.categoriesViewModel);

  ValueNotifier<LoginModel> get loginModel => viewModel.loginModel;

  login(email, password, context) async {
    if (!email.contains('@') || !email.contains('.com')) {
      showAlertDialog(context, 'Email Invalido!', 'Login');
    } else {
      try {
        var response = await viewModel.login(email, password);

        if (response.statusCode == 200) {
          if (loginModel.value.passed == 1) {
            await getValues();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NavigationBarComponent(allCategories, allProducts)),
            );
          } else {
            showAlertDialog(context, loginModel.value.message ?? '', 'Login');
          }
        } else {
          showAlertDialog(context, 'Erro na requisicao!', 'Login');
        }
      } catch (error) {
        showAlertDialog(context, 'Erro no servidor!', 'Login');
      }
    }
  }

  getValues() async {
    try {
      allCategories = await categoriesViewModel.getAllCategories();
      allProducts = await productsViewModel.getAllProducts();
      return [allCategories, allProducts];
    } catch (error) {
      return error;
    }
  }
}
