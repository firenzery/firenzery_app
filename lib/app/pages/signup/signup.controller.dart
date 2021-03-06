import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/signup/signup.page.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';

class SignUpController extends SignupPage {
  final UserViewModel viewModel;

  const SignUpController(this.viewModel);

  ValueNotifier<UserModel> get registerModel => viewModel.userModel;

  register(context, UserModel user) async {
    try {
      var response = await viewModel.register(user);

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        showAlertDialog(context, 'Erro ao se cadastrar!', 'Cadastro');
      }
    } catch (error) {
      showAlertDialog(context, 'Erro ao se cadastrar!', 'Cadastro');
    }
  }
}
