import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/signup/signup.page.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum SignUpState { idle, success, error, serverError, loading }

class SignUpController extends ChangeNotifier {
  SignUpState state = SignUpState.idle;
  late final messageError;

  register(UserModel user, UserViewModel userViewModel) async {
    state = SignUpState.loading;
    notifyListeners();

    try {
      var response = await userViewModel.register(user);

      if (response.statusCode == 200) {
        state = SignUpState.success;
        notifyListeners();
      } else {
        state = SignUpState.error;
        messageError = response.body;
        notifyListeners();
      }
    } catch (error) {
      state = SignUpState.serverError;
      notifyListeners();
    }
  }
}
