import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/pages/login/login.page.dart';
import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<SplashController>();

    controller.addListener(() {
      if (controller.state == AuthState.authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationBarComponent()),
        );
      } else if (controller.state == AuthState.unauthenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 2000),
        () => controller.navigateToPage(userViewModel));

    return const Scaffold(
      body: Center(
          child: Text(
        'Firenzery',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      )),
    );
  }
}
