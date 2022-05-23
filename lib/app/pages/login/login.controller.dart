import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:flutter/material.dart';

import '../../models/login.model.dart';
import '../../viewmodels/user.viewmodel.dart';

import '../home/home.page.dart';
import 'components/alertDialog.dart';

class LoginController extends LoginPage {
  final UserViewModel viewModel;

  const LoginController(this.viewModel);

  ValueNotifier<LoginModel> get loginModel => viewModel.loginModel;

  login(email, password, context) async {
    if (!email.contains('@') || !email.contains('.com')) {
      showAlertDialog(context, 'Email Invalido!', 'Login');
    } else {
      var response = await viewModel.login(email, password);

      if (response.statusCode == 200) {
        if (loginModel.value.passed == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          showAlertDialog(context, loginModel.value.message ?? '', 'Login');
        }
      } else {
        showAlertDialog(context, 'Erro na requisicao!', 'Login');
      }
    }
  }
}
