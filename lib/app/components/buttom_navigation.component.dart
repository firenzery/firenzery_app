import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBarComponent extends StatefulWidget {
  const NavigationBarComponent();

  @override
  State<NavigationBarComponent> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBarComponent> {
  int _currentTab = 0;

  bool loadedOnceFromRoute = false;

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);

    final List<Widget> tabs = [HomePage(), const RequestsPage(), PersonPage()];

    return Scaffold(
      body: tabs[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primaryColor,
        fixedColor: Colors.white,
        currentIndex: _currentTab,
        onTap: (indexOfClickedTab) {
          setState(() {
            _currentTab = indexOfClickedTab;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          )
        ],
      ),
    );
  }
}
