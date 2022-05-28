import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/list_categories.model.dart';
import 'package:firenzery/app/models/list_new_products.model.dart';
import 'package:firenzery/app/models/list_products.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/person/person.page.dart';
import 'package:firenzery/app/pages/requests/requests.page.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationBarComponent extends StatefulWidget {
  final AdressModel adress;
  final UserModel user;

  const NavigationBarComponent(this.adress, this.user);

  @override
  State<NavigationBarComponent> createState() => NavigationBarState();
}

class NavigationBarState extends State<NavigationBarComponent> {
  int _currentTab = 0;

  bool loadedOnceFromRoute = false;

  @override
  Widget build(BuildContext context) {
    var allProductsModel =
        Provider.of<ListProductsModel>(context, listen: false);
    var allCategoriesModel =
        Provider.of<ListCategoriesModel>(context, listen: false);
    var newProductsModel =
        Provider.of<ListNewProductsModel>(context, listen: false);

    final List<Widget> tabs = [
      HomePage(allCategoriesModel.categories(), allProductsModel.products(),
          newProductsModel.products(), widget.adress, widget.user),
      const RequestsPage(),
      PersonPage()
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
