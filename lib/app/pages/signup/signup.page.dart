import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/signup/signup.controller.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SignupPage> {
  final controller =
      SignUpController(UserViewModel(UserService(ClientHttpSevice())));

  final DateTime today = DateTime.now();

  final TextEditingController _dateNascController = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Primeiro Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.firstName = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Sobrenome'),
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.surname = value;
              },
            ),
            TextFormField(
              controller: _dateNascController,
              decoration:
                  const InputDecoration(labelText: 'Data de Nascimento'),
              enableInteractiveSelection: false,
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onTap: () => showDatePicker(
                      context: context,
                      initialDate: today,
                      firstDate: DateTime(1970),
                      lastDate: today)
                  .then((date) => {
                        _dateNascController.text = date.toString(),
                        user.dateNasc = date.toString()
                      }),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.email = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.password = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Cpf'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.cpf = int.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Celular'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {}
                return null;
              },
              onChanged: (value) {
                user.nrPhone = int.parse(value);
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
                  controller.register(context, user);
                },
              )),
            ),
          ]),
        ),
      ),
    );
  }
}
