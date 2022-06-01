import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:flutter/material.dart';
import '../../viewmodels/user.viewmodel.dart';

enum AuthState { idle, success, error, errorServer, loading }

class LoginController extends ChangeNotifier {
  final UserViewModel userViewModel = UserViewModel(
      UserService(ClientHttpSevice()), SharedPreferencesService());
  final AdressViewModel adressViewModel =
      AdressViewModel(AdressService(ClientHttpSevice()));

  AuthState state = AuthState.idle;

  late final messageError;

  ValueNotifier<UserModel> get userModel => userViewModel.userModel;
  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  login(email, password, keepConnected) async {
    state = AuthState.loading;
    notifyListeners();

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

        state = AuthState.success;
        notifyListeners();
      } else {
        messageError = resp.body;
        state = AuthState.error;
        notifyListeners();
      }
    } catch (error) {
      state = AuthState.errorServer;
      notifyListeners();
    }
  }
}
