import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class NavigationBarComponent extends StatefulWidget {
  final List categories;
  final List products;

  const NavigationBarComponent(this.categories, this.products, {Key? key})
      : super(key: key);

  @override
  State<NavigationBarComponent> createState() =>
      NavigationBarState(categories, products);
}

class NavigationBarState extends State<NavigationBarComponent> {
  final List categories;
  final List products;

  NavigationBarState(this.categories, this.products);

  int _currentTab = 0;

  bool loadedOnceFromRoute = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomePage(categories, products),
      const RequestsPage(),
      PersonPage(categories, products)
    ];

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
