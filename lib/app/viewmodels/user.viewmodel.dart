import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class UserViewModel {
  final IUser userService;
  final ILocaleStorage localeService;

  final userModelNotifier = ValueNotifier<UserModel>(UserModel());

  UserViewModel(this.userService, this.localeService);

  getUser(id) async {
    try {
      var resp = await userService.getUser(id);

      userModelNotifier.value =
          UserModel.fromJson(convert.jsonDecode(resp.body));

      return resp;
    } catch (error) {
      throw error;
    }
  }

  register(UserModel user) async {
    try {
      var resp = await userService.register(user);

      if (resp.statusCode == 200) {
        userModelNotifier.value =
            UserModel.fromJson(convert.jsonDecode(resp.body));
      }

      return resp;
    } catch (error) {
      throw error;
    }
  }

  login(email, password) async {
    try {
      var resp = await userService.login(email, password);

      if (resp.statusCode == 200) {
        userModelNotifier.value =
            UserModel.fromJson(convert.jsonDecode(resp.body));
      }

      return resp;
    } catch (error) {
      throw error;
    }
  }

  saveCredentialsLocale(key, value) async {
    await localeService.addValue(key, value);
  }

  getCredentialsLocale(key) async {
    return await localeService.getValue(key);
  }
}
