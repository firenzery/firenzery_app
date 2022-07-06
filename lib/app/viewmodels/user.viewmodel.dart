import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class UserViewModel extends ChangeNotifier {
  final IUser userService = UserService(ClientHttpSevice());
  final ILocaleStorage localeService = SharedPreferencesService();

  UserModel userModel = UserModel();

  getUser(int id) async {
    try {
      var resp = await userService.getUser(id);

      userModel = UserModel.fromJson(convert.jsonDecode(resp.body));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  register(UserModel user) async {
    try {
      var resp = await userService.register(user);

      if (resp.statusCode == 200) {
        userModel = UserModel.fromJson(convert.jsonDecode(resp.body));

        notifyListeners();
      }
      return resp;
    } catch (error) {
      rethrow;
    }
  }

  login(String email, String password) async {
    try {
      var resp = await userService.login(email, password);

      if (resp.statusCode == 200) {
        userModel = UserModel.fromJson(convert.jsonDecode(resp.body));

        notifyListeners();
      }

      return resp;
    } catch (error) {
      rethrow;
    }
  }

  saveCredentialsLocale(key, value) async {
    await localeService.addValue(key, value);
  }

  getCredentialsLocale(key) async {
    return await localeService.getValue(key);
  }
}
