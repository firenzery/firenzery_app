import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
  );

  @override
  void initState() {
    super.initState();
    controller.navigateToPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Text(
          'Firenzery',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}
