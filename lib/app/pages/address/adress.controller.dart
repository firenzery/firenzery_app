import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.page.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';

enum AdressState { idle, error, success, loading }

class AdressController extends ChangeNotifier {
  AdressState state = AdressState.idle;

  updateAdress(AdressModel newAdress, AdressViewModel adressViewModel) async {
    try {
      state = AdressState.loading;
      notifyListeners();

      await adressViewModel.updateAdress(newAdress);

      state = AdressState.success;
      notifyListeners();
    } catch (error) {
      state = AdressState.error;
      notifyListeners();
    }
  }

  createAdress(AdressModel newAdress, AdressViewModel adressViewModel) async {
    try {
      state = AdressState.loading;
      notifyListeners();

      newAdress.idClient = newAdress.idClient;

      await adressViewModel.createAdress(newAdress);

      state = AdressState.success;
      notifyListeners();
    } catch (error) {
      state = AdressState.error;
      notifyListeners();
    }
  }
}
