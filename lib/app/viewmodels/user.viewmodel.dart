import 'package:firenzery/app/interfaces/user.interface.dart';
import 'package:firenzery/app/models/login.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserViewModel {

  final IUser service;

  final userModel = ValueNotifier<UserModel>(UserModel(idClient: null, firstName: null, surname: null, dateNasc: null, email: null, cpf: null, nrPhone: null));
  final loginModel = ValueNotifier<LoginModel>(LoginModel(passed: null, message: null));

  UserViewModel(this.service);

  getUser(id) async {
    userModel.value = await service.getUser(id);
  }

  login(email, password) async {
    loginModel.value = await service.login(email, password);
  }
}