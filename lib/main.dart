import 'package:firenzery/app/models/list_categories.model.dart';
import 'package:firenzery/app/models/list_new_products.model.dart';
import 'package:firenzery/app/models/list_products.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/splash/splash.page.dart';
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
          ChangeNotifierProvider(create: (context) => ListProductsModel()),
          ChangeNotifierProvider(create: (context) => ListCategoriesModel()),
          ChangeNotifierProvider(create: (context) => ListNewProductsModel())
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
