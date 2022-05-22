import 'package:brasil_fields/brasil_fields.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/signup/signup.controller.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Primeiro Nome'),
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Sobrenome'),
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
            TextFormField(
                controller: _dateNascController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Data de Nascimento'),
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cpf'),
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
            TextFormField(
              decoration: const InputDecoration(labelText: 'Celular'),
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
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [
                    Color(0xFFF58524),
                    Color(0XFFF92B7F),
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                  child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    controller.register(context, user);
                  }
                },
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
