import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class AdressPage extends StatefulWidget {
  final List allProducts;
  final List allCategories;
  final UserModel user;
  final AdressModel oldAdress;

  AdressPage(this.oldAdress, this.user, this.allCategories, this.allProducts);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  final controller = AdressController(
      AdressViewModel(AdressService(ClientHttpSevice())),
      UserViewModel(
          UserService(ClientHttpSevice()), SharedPreferencesService()));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerApartment = TextEditingController();
  final TextEditingController _controllerGroup = TextEditingController();
  final TextEditingController _controllerBlock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool adressExist = widget.oldAdress.idAdress != null;

    if (adressExist) {
      _controllerApartment.text = '${widget.oldAdress.apartment}';
      _controllerGroup.text = '${widget.oldAdress.group}';
      _controllerBlock.text = '${widget.oldAdress.block}';
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
                          height: 10,
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
                                          context,
                                          AdressModel(
                                              idClient:
                                                  widget.oldAdress.idClient,
                                              idAdress:
                                                  widget.oldAdress.idAdress,
                                              apartment: int.parse(
                                                  _controllerApartment.text),
                                              group: int.parse(
                                                  _controllerGroup.text),
                                              block: _controllerBlock.text),
                                          widget.user,
                                          widget.allCategories,
                                          widget.allProducts);
                                    } else {
                                      controller.createAdress(
                                          context,
                                          AdressModel(
                                              idClient: widget.user.idClient,
                                              apartment: int.parse(
                                                  _controllerApartment.text),
                                              group: int.parse(
                                                  _controllerGroup.text),
                                              block: _controllerBlock.text),
                                          widget.user,
                                          widget.allCategories,
                                          widget.allProducts);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: primaryColor,
                                      shape: const StadiumBorder()),
                                  child: Text(
                                      adressExist ? "Atualizar" : "Cadastrar"),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )))));
  }
}
