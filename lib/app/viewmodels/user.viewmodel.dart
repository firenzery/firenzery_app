import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/login.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserViewModel {
  final IUser userService;
  final ILocaleStorage localeService;

  final userModel = ValueNotifier<UserModel>(UserModel(
      idClient: null,
      firstName: null,
      surname: null,
      dateNasc: null,
      email: null,
      cpf: null,
      nrPhone: null));

  final loginModel =
      ValueNotifier<LoginModel>(LoginModel(passed: null, message: null));

  UserViewModel(this.userService, this.localeService);

  getUser(id) async {
    var resp = await userService.getUser(id);

    userModel.value = UserModel.fromJson(resp);

    return resp;
  }

  register(UserModel user) async {
    try {
      var resp = await userService.register(user);

      userModel.value = UserModel.fromJson(resp.data);

      return resp;
    } catch (error) {
      return error;
    }
  }

  login(email, password) async {
    var resp = await userService.login(email, password);

    loginModel.value = LoginModel.fromJson(resp.data);

    return resp;
  }

  saveCredentialsLocale(key, value) async {
    await localeService.addValue(key, value);
  }

  getCredentialsLocale(key) async {
    return await localeService.getValue(key);
  }
}
