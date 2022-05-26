import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/pages/cart/cart.page.dart';
import 'package:firenzery/app/pages/home/home.controller.dart';
import 'package:firenzery/app/services/remote/categories.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/products.service.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';

class HomePage extends StatefulWidget {
  final List allCategories;
  final List allProducts;

  HomePage(this.allCategories, this.allProducts);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(
      ProductsViewModel(ProductsService(ClientHttpSevice())),
      CategoriesViewModel(CategoriesService(ClientHttpSevice())), [
    CategoryModel(
      icon: '',
      title: '',
      type: 0,
    )
  ], [
    ProductModel(image: '', name: '', type: 0, price: 0.00)
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/Location.svg"),
              const SizedBox(width: defaultPadding / 2),
              Text(
                "APARTAMENTO 142 GRUPO 15",
                style: Theme.of(context).textTheme.bodyText1,
              ),
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: defaultPadding * 4),
              Text(
                "Firenzery",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              const Text(
                "O melhor do parque firenzy",
                style: TextStyle(fontSize: 18),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: defaultPadding),
                child: SearchForm(),
              ),
              Categories(widget.allCategories, widget.allProducts),
              NewArrivalProducts(
                  controller.getFiveProductsbyCategory(widget.allProducts, 1),
                  1),
              PopularProducts(
                  controller.getFiveProductsbyCategory(widget.allProducts, 1),
                  1),
            ],
          ),
        ));
  }
}
