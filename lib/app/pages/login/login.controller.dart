import 'dart:js';

import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:flutter/material.dart';

import '../../models/login.model.dart';
import '../../viewmodels/user.viewmodel.dart';
import 'package:flutter/cupertino.dart';

import '../home/home.page.dart';

class LoginController extends LoginPage{
    final UserViewModel viewModel;

    LoginController(this.viewModel);

    ValueNotifier<LoginModel> get loginModel => viewModel.loginModel;
    
    login(email, password) {
      viewModel.login(email, password);
    }
}