import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/user.viewmodel.dart';
import 'components/alertDialog.dart';

class LoginController extends LoginPage {
  final UserViewModel userViewModel;
  final AdressViewModel adressViewModel;

  LoginController(this.userViewModel, this.adressViewModel);

  ValueNotifier<UserModel> get userModel => userViewModel.userModel;
  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  login(context, email, password, keepConnected) async {
    if (!email.contains('@') || !email.contains('.com')) {
      showAlertDialog(context, 'Email Invalido!', 'Login');
    } else {
      try {
        var resp = await userViewModel.login(email, password);

        if (resp.statusCode == 200) {
          if (keepConnected) {
            await userViewModel.saveCredentialsLocale(
                'idClient', userModel.value.idClient);
            await userViewModel.saveCredentialsLocale('email', email);
            await userViewModel.saveCredentialsLocale('password', password);
          }

          await adressViewModel.getAdress(userModel.value.idClient);

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    NavigationBarComponent(adressModel.value, userModel.value)),
          );
        } else {
          showAlertDialog(context, resp.body, 'Login');
        }
      } catch (error) {
        showAlertDialog(context, 'Erro no Servidor!', 'Login');
      }
    }
  }
}
