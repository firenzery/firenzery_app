import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NavigationBarComponent extends StatefulWidget {
  const NavigationBarComponent({Key? key}) : super(key: key);

  @override
  State<NavigationBarComponent> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBarComponent> {
  int _currentTab = 0;
  final List<Widget> _tabs = [
    HomePage(),
    const RequestsPage(),
    const PersonPage()
  ];

  bool loadedOnceFromRoute = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentTab],
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
