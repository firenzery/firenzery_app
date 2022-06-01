import 'package:firenzery/app/interfaces/locale_storage.interface.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable

enum ExitState { idle, loading, success }

class PersonController extends ChangeNotifier {
  ILocaleStorage service = SharedPreferencesService();

  ExitState state = ExitState.idle;

  exit() async {
    state = ExitState.loading;
    notifyListeners();

    await service.removeValue('email');
    await service.removeValue('password');

    state = ExitState.success;
    notifyListeners();
  }
}
