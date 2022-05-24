import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

import '../../services/remote/client_http.service.dart';
import '../../services/remote/user.service.dart';
import '../../viewmodels/user.viewmodel.dart';
import '../resetpassword/reset_password.page.dart';
import '../signup/signup.page.dart';
import 'login.controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _State();
}

class _State extends State<LoginPage> {
  final controller = LoginController(
      UserViewModel(UserService(ClientHttpSevice())),
      ProductsViewModel(ProductsService(ClientHttpSevice())),
      CategoriesViewModel(CategoriesService(ClientHttpSevice())));

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
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
            Container(
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  "Recuperar Senha",
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
                        controller.login(email, password, context);
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
                      builder: (context) => const SignupPage(),
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
