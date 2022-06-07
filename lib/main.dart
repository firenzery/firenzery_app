import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.controller.dart';
import 'package:firenzery/app/pages/cart/cart.controller.dart';
import 'package:firenzery/app/pages/finalize_purchase/finalize_purchase.controller.dart';
import 'package:firenzery/app/pages/home/home.controller.dart';
import 'package:firenzery/app/pages/login/login.controller.dart';
import 'package:firenzery/app/pages/payment_method/payment_method.controller.dart';
import 'package:firenzery/app/pages/person/person.controller.dart';
import 'package:firenzery/app/pages/request_detail/request_detail.controller.dart';
import 'package:firenzery/app/pages/requests/requests.controller.dart';
import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/app/pages/splash/splash.page.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //Controllers
          ChangeNotifierProvider(create: (context) => LoginController()),
          ChangeNotifierProvider(create: (context) => PersonController()),
          ChangeNotifierProvider(create: (context) => SplashController()),
          ChangeNotifierProvider(create: (context) => HomeController()),
          ChangeNotifierProvider(create: (context) => AdressController()),
          ChangeNotifierProvider(create: (context) => CartController()),
          ChangeNotifierProvider(create: (context) => RequestController()),
          ChangeNotifierProvider(
              create: (context) => FinalizePurchaseController()),
          ChangeNotifierProvider(
              create: (context) => PaymentMethodController()),
          ChangeNotifierProvider(
              create: (context) => RequestDetailController()),

          //ViewModels
          ChangeNotifierProvider(create: (context) => UserViewModel()),
          ChangeNotifierProvider(create: (context) => AdressViewModel()),
          ChangeNotifierProvider(create: (context) => CategoriesViewModel()),
          ChangeNotifierProvider(create: (context) => ProductsViewModel()),
          ChangeNotifierProvider(create: (context) => SaleViewModel())
        ],
        child: MaterialApp(
            title: 'Main',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashPage()));
  }
}
