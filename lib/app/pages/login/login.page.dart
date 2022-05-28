import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

import '../../services/remote/client_http.service.dart';
import '../../services/remote/user.service.dart';
import '../../viewmodels/user.viewmodel.dart';
import '../resetpassword/reset_password.page.dart';
import '../signup/signup.page.dart';
import 'login.controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage();

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  final controller = LoginController(
      UserViewModel(
          UserService(ClientHttpSevice()), SharedPreferencesService()),
      AdressViewModel(AdressService(ClientHttpSevice())));

  String email = '';
  String password = '';
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange;
      }
      return primaryColor;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "E-mail",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
              ),
              onChanged: (value) => email = value,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              // autofocus: true,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.black,
                ),
              ),
              onChanged: (value) => password = value,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text('Manter conectado'),
              ],
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
                        controller.login(context, email, password, isChecked);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor, shape: const StadiumBorder()),
                      child: const Text("Login"),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: TextButton(
                child: const Text(
                  "Esqueceu a senha?",
                  textAlign: TextAlign.right,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordPage(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                child: const Text(
                  "Cadastre-se",
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
