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

  LoginController(this.viewModel) : super([], []);

  ValueNotifier<LoginModel> get loginModel => viewModel.loginModel;

  login(email, password, context, keepConnected, allCategories,
      allProducts) async {
    if (!email.contains('@') || !email.contains('.com')) {
      showAlertDialog(context, 'Email Invalido!', 'Login');
    } else {
      try {
        var response = await viewModel.login(email, password);

        if (keepConnected) {
          await viewModel.saveCredentialsLocale('email', email);
          await viewModel.saveCredentialsLocale('password', password);
        }

        if (response.statusCode == 200) {
          if (loginModel.value.passed == 1) {
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
}
