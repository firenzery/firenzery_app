import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:flutter/material.dart';
import '../../models/login.model.dart';
import '../../viewmodels/user.viewmodel.dart';
import 'components/alertDialog.dart';

class LoginController extends LoginPage {
  final UserViewModel userViewModel;
  final AdressViewModel adressViewModel;

  LoginController(this.userViewModel, this.adressViewModel) : super([], []);

  ValueNotifier<LoginModel> get loginModel => userViewModel.loginModel;
  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  login(context, email, password, keepConnected, allCategories,
      allProducts) async {
    if (!email.contains('@') || !email.contains('.com')) {
      showAlertDialog(context, 'Email Invalido!', 'Login');
    } else {
      try {
        var response = await userViewModel.login(email, password);

        if (keepConnected) {
          await userViewModel.saveCredentialsLocale(
              'idClient', loginModel.value.idClient);
          await userViewModel.saveCredentialsLocale('email', email);
          await userViewModel.saveCredentialsLocale('password', password);
        }

        if (response.statusCode == 200) {
          var adress =
              await adressViewModel.getAdress(loginModel.value.idClient);
          if (loginModel.value.passed == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NavigationBarComponent(allCategories,
                      allProducts, adress, loginModel.value.idClient!)),
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
