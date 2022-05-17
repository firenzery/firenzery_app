import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/login.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserViewModel {
  final IUser service;

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

  UserViewModel(this.service);

  getUser(id) async {
    var resp = await service.getUser(id);

    userModel.value = UserModel.fromJson(resp);

    return resp;
  }

  register(UserModel user) async {
    var resp = await service.register(user);

    userModel.value = UserModel.fromJson(resp.data);

    return resp;
  }

  login(email, password) async {
    var resp = await service.login(email, password);

    loginModel.value = LoginModel.fromJson(resp.data);

    return resp;
  }
}
