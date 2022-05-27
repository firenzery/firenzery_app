import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController(
      SharedPreferencesService(),
      CategoriesViewModel(CategoriesService(ClientHttpSevice())),
      ProductsViewModel(ProductsService(ClientHttpSevice())),
      AdressViewModel(AdressService(ClientHttpSevice())),
      UserViewModel(
          UserService(ClientHttpSevice()), SharedPreferencesService()));

  @override
  void initState() {
    super.initState();
    controller.navigateToPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text(
        'Firenzery',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )),
    );
  }
}
