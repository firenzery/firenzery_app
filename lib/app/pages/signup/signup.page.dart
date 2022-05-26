import 'package:brasil_fields/brasil_fields.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/signup/components/text_form.component.dart';
import 'package:firenzery/app/pages/signup/signup.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  final allCategories;
  final allProducts;

  const SignupPage(this.allCategories, this.allProducts, {Key? key})
      : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final controller = SignUpController(UserViewModel(
      UserService(ClientHttpSevice()), SharedPreferencesService()));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final DateTime today = DateTime.now();

  final TextEditingController _dateNascController = TextEditingController();

  final numberSingle = RegExp(r'[^\d]+');

  bool overAgeWorker(String birthDateWorker, int ageMin) {
    String datePattern = "dd/MM/yyyy";

    DateTime birthDate = DateFormat(datePattern).parse(birthDateWorker);
    DateTime today = DateTime.now();

    int yearDiff = today.year - birthDate.year;
    int monthDiff = today.month - birthDate.month;
    int dayDiff = today.day - birthDate.day;

    return yearDiff > ageMin ||
        yearDiff == ageMin && monthDiff >= 0 && dayDiff >= 0;
  }

  UserModel user = UserModel(
      idClient: null,
      firstName: null,
      surname: null,
      dateNasc: null,
      email: null,
      password: null,
      cpf: null,
      nrPhone: null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            TextFormComponent(
              text: 'Primeiro Nome',
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Primeiro Nome Obrigatorio!';
                } else {
                  return null;
                }
              },
              change: (value) {
                user.firstName = value;
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
              text: 'Sobrenome',
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sobrenome Obrigatorio!';
                } else {
                  return null;
                }
              },
              change: (value) {
                user.surname = value;
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
                text: 'Data de Nascimento',
                controller: _dateNascController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter()
                ],
                valid: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data Obrigatoria!';
                  } else if (_dateNascController.text.length != 10) {
                    return 'Data Invalida!';
                  } else if (!overAgeWorker(_dateNascController.text, 16)) {
                    return 'Idade minima de 16';
                  }

                  return null;
                },
                change: (value) {
                  user.dateNasc = value;
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
              text: 'Email',
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email Obrigatorio!';
                } else if (!value.contains("@") || !value.contains(".com")) {
                  return 'Email Invalido!';
                } else {
                  return null;
                }
              },
              change: (value) {
                user.email = value;
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
              text: 'Senha',
              isObscured: true,
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Senha Obrigatoria!';
                } else {
                  return null;
                }
              },
              change: (value) {
                user.password = value;
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
              text: 'Cpf',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Cpf Obrigatorio!';
                } else if (value.length != 14) {
                  return 'Cpf Invalido';
                } else {
                  return null;
                }
              },
              change: (value) {
                String data = value.replaceAll(numberSingle, '');
                user.cpf = int.parse(data);

                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormComponent(
              text: 'Celular',
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              valid: (value) {
                if (value == null || value.isEmpty) {
                  return 'Número de Celular Obrigatorio!';
                } else if (value.length != 15) {
                  return 'Numero de Celular Invalido';
                } else {
                  return null;
                }
              },
              change: (value) {
                String data = value.replaceAll(numberSingle, '');
                user.nrPhone = int.parse(data);

                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          controller.register(context, user,
                              widget.allCategories, widget.allProducts);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor, shape: const StadiumBorder()),
                      child: const Text("Cadastrar"),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
