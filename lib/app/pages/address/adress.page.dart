import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.controller.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  late final controller;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerApartment = TextEditingController();
  final TextEditingController _controllerGroup = TextEditingController();
  final TextEditingController _controllerBlock = TextEditingController();

  late AdressViewModel adressViewModel;
  late UserViewModel userViewModel;

  @override
  void initState() {
    super.initState();
    controller = context.read<AdressController>();

    adressViewModel = Provider.of<AdressViewModel>(context, listen: false);
    userViewModel = Provider.of<UserViewModel>(context, listen: false);

    controller.addListener(() {
      if (controller.state == AdressState.success) {
        if (adressViewModel.adressModel.idAdress != null) {
          Future.delayed(
              const Duration(milliseconds: 100), () => Navigator.pop(context));
        }
      } else if (controller.state == AdressState.error) {
        showAlertDialog(context, 'Erro ao atualizar seu endereço!', 'Endereço');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AdressModel adress = adressViewModel.adressModel;
    UserModel user = userViewModel.userModel;

    bool adressExist = adress.idAdress != null;

    if (adressExist) {
      _controllerApartment.text = '${adress.apartment}';
      _controllerGroup.text = '${adress.group}';
      _controllerBlock.text = '${adress.block}';
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _controllerApartment,
                  // autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Apartamento",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.length > 3) {
                      return 'Numero Inválido!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _controllerBlock,
                  // autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Bloco",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.length > 1) {
                      return 'Bloco Inválido!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _controllerGroup,
                  // autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Grupo",
                    labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  style: const TextStyle(fontSize: 20),
                  validator: (value) {
                    if (value!.length > 2) {
                      return 'Grupo Inválido!';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (adressExist) {
                              controller.updateAdress(
                                  AdressModel(
                                      idClient: adress.idClient,
                                      idAdress: adress.idAdress,
                                      apartment:
                                          int.parse(_controllerApartment.text),
                                      group: int.parse(_controllerGroup.text),
                                      block: _controllerBlock.text),
                                  adressViewModel);
                            } else {
                              controller.createAdress(
                                  AdressModel(
                                      idClient: user.idClient,
                                      apartment:
                                          int.parse(_controllerApartment.text),
                                      group: int.parse(_controllerGroup.text),
                                      block: _controllerBlock.text),
                                  adressViewModel);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: primaryColor,
                              shape: const StadiumBorder()),
                          child: Text(adressExist ? "Atualizar" : "Cadastrar"),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
