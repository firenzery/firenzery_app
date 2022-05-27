import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/login.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.page.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';

class AdressController extends AdressPage {
  AdressViewModel adressViewModel;
  UserViewModel userViewModel;

  AdressController(this.adressViewModel, this.userViewModel)
      : super(AdressModel(), null, [], []);

  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  updateAdress(context, newAdress, idClient, allCategories, allProducts) async {
    try {
      var adress = await adressViewModel.updateAdress(newAdress);

      if (adress.idAdress != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationBarComponent(
                  allCategories, allProducts, adress, idClient)),
        );
      }
    } catch (error) {
      showAlertDialog(context, 'Erro ao atualizar seu endereço!', 'Endereço');
    }
  }

  createAdress(context, newAdress, idClient, allCategories, allProducts) async {
    try {
      newAdress.idClient = idClient;
      var adress = await adressViewModel.createAdress(newAdress);

      if (adress.idAdress > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationBarComponent(
                  allCategories, allProducts, adress, idClient)),
        );
      }
    } catch (error) {
      showAlertDialog(context, 'Erro ao atualizar seu endereço!', 'Endereço');
    }
  }
}
