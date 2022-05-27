import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';

class NavigationBarComponent extends StatefulWidget {
  final List categories;
  final List products;
  final AdressModel adress;
  final UserModel user;

  const NavigationBarComponent(
      this.categories, this.products, this.adress, this.user,
      {Key? key})
      : super(key: key);

  @override
  State<NavigationBarComponent> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBarComponent> {
  int _currentTab = 0;

  bool loadedOnceFromRoute = false;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomePage(widget.categories, widget.products, widget.adress, widget.user),
      const RequestsPage(),
      PersonPage(widget.categories, widget.products, widget.adress)
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
