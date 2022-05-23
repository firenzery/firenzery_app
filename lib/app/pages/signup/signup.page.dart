import 'package:brasil_fields/brasil_fields.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/components/search_form.dart';
import 'package:firenzery/app/pages/signup/signup.controller.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  final controller =
      SignUpController(UserViewModel(UserService(ClientHttpSevice())));

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

  DateTime? _valueDateNasc;

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
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Primeiro Nome",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Primeiro Nome Obrigatorio!';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  user.firstName = value;
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Sobrenome",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sobrenome Obrigatorio!';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  user.surname = value;
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                  controller: _dateNascController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Data de Nascimento",
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    errorBorder: outlineInputBorder,
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding,
                          vertical: defaultPadding / 2),
                      child: SizedBox(
                        width: 48,
                        height: 48,
                      ),
                    ),
                  ),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data Obrigatoria!';
                    } else if (_dateNascController.text.length != 10) {
                      return 'Data Invalida!';
                    } else if (!overAgeWorker(_dateNascController.text, 16)) {
                      return 'Idade minima de 16';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    user.dateNasc = value;
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email Obrigatorio!';
                  } else if (!value.contains("@") || !value.contains(".com")) {
                    return 'Email Invalido!';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  user.email = value;
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Senha Obrigatoria!';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  user.password = value;
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Cpf",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Cpf Obrigatorio!';
                  } else if (value.length != 14) {
                    return 'Cpf Invalido';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  String data = value.replaceAll(numberSingle, '');
                  user.cpf = int.parse(data);

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Material(
              elevation: 5.0,
              shadowColor: primaryColor,
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Celular",
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: outlineInputBorder,
                  errorBorder: outlineInputBorder,
                  suffixIcon: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding / 2),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Número de Celular Obrigatorio!';
                  } else if (value.length != 15) {
                    return 'Numero de Celular Invalido';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  String data = value.replaceAll(numberSingle, '');
                  user.nrPhone = int.parse(data);

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                },
              ),
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
                          controller.register(context, user);
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
