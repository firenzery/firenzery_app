import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/address/adress.page.dart';
import 'package:firenzery/app/pages/cart/cart.page.dart';
import 'package:firenzery/app/pages/home/home.controller.dart';
import 'package:firenzery/app/pages/login/login.controller.dart';
import 'package:firenzery/app/pages/splash/splash.controller.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';

class HomePage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomePage();

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    controller = context.read<HomeController>();

    controller.addListener(() {
      if (controller.state == GetValuesState.loading) {
      } else if (controller.state == GetValuesState.error) {}
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AdressViewModel adressViewModel =
        Provider.of<AdressViewModel>(context, listen: false);

    UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);

    CategoriesViewModel categoriesViewModel =
        Provider.of<CategoriesViewModel>(context, listen: false);

    ProductsViewModel productsViewModel =
        Provider.of<ProductsViewModel>(context, listen: false);

    Future.delayed(
        const Duration(milliseconds: 2000),
        () => controller.getValues(userViewModel.userModel.idClient!,
            categoriesViewModel, productsViewModel, adressViewModel));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/Location.svg"),
              const SizedBox(width: defaultPadding / 2),
              Consumer<HomeController>(
                  builder: (BuildContext context, controller, Widget? child) {
                return InkWell(
                    child: Text(
                      adressViewModel.adressModel.idClient != null
                          ? '${adressViewModel.adressModel.apartment}${adressViewModel.adressModel.block} GRUPO ${adressViewModel.adressModel.group}'
                          : 'CADASTRAR ENDEREÇO',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdressPage()));
                    });
              })
            ],
          ),
          actions: [
            IconButton(
              icon: SvgPicture.asset("assets/icons/cart_icon.svg"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          color: Colors.white,
          backgroundColor: primaryColor,
          onRefresh: (() => controller.getValues(
              userViewModel.userModel.idClient!,
              categoriesViewModel,
              productsViewModel,
              adressViewModel)),
          child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.all(defaultPadding),
              child: Consumer<HomeController>(
                  builder: (BuildContext context, controller, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: defaultPadding / 2),
                      child: Text(
                        "Firenzery",
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ),
                    const Text(
                      "O melhor do parque firenzy",
                      style: TextStyle(fontSize: 18),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: defaultPadding * 1.5),
                      child: SearchForm(),
                    ),
                    Categories(categoriesViewModel.categories,
                        productsViewModel.newArrivedProducts),
                    NewArrivalProducts(productsViewModel.newArrivedProducts),
                    PopularProducts(
                        popularProductsList:
                            productsViewModel.newArrivedProducts,
                        categoryId: 1)
                  ],
                );
              })),
        ));
  }
}
