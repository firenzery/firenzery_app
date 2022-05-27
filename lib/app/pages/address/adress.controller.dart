import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
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
      : super(AdressModel(), UserModel(), [], []);

  ValueNotifier<AdressModel> get adressModel => adressViewModel.adressModel;

  updateAdress(context, newAdress, user, allCategories, allProducts) async {
    try {
      await adressViewModel.updateAdress(newAdress);

      if (adressModel.value.idAdress != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationBarComponent(
                  allCategories, allProducts, adressModel.value, user)),
        );
      }
    } catch (error) {
      showAlertDialog(context, 'Erro ao atualizar seu endereço!', 'Endereço');
    }
  }

  createAdress(context, newAdress, idClient, allCategories, allProducts) async {
    try {
      newAdress.idClient = idClient;

      await adressViewModel.createAdress(newAdress);

      if (adressModel.value.idAdress != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationBarComponent(
                  allCategories, allProducts, adressModel.value, user)),
        );
      }
    } catch (error) {
      showAlertDialog(context, 'Erro ao atualizar seu endereço!', 'Endereço');
    }
  }
}
