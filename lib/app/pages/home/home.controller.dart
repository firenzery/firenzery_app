import 'package:firenzery/app/models/address.model.dart';
import 'package:firenzery/app/models/category.model.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/user.model.dart';
import 'package:firenzery/app/pages/home/home.page.dart';
import 'package:firenzery/app/pages/login/login.controller.dart';
import 'package:firenzery/app/services/local/shared_preferences.service.dart';
import 'package:firenzery/app/services/remote/adress.service.dart';
import 'package:firenzery/app/services/remote/client_http.service.dart';
import 'package:firenzery/app/services/remote/user.service.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/categories.viewmodel.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';

// ignore: must_be_immutable
class HomeController extends HomePage {
  final ProductsViewModel productsViewModel;
  final CategoriesViewModel categoriesViewModel;

  final adressModel = LoginController(
          UserViewModel(
              UserService(ClientHttpSevice()), SharedPreferencesService()),
          AdressViewModel(AdressService(ClientHttpSevice())))
      .adressModel;

  AdressModel adress;
  UserModel user;
  List products;
  List categories;
  List newArrivalProducts;

  HomeController(
      this.productsViewModel,
      this.categoriesViewModel,
      this.categories,
      this.products,
      this.newArrivalProducts,
      this.adress,
      this.user)
      : super(categories, products, newArrivalProducts, adress, user);

  getFiveProductsbyCategory(allProducts, categoryId) {
    return allProducts
        .where((data) => data.type == categoryId)
        .toList()
        .getRange(0, allProducts.length >= 5 ? 5 : allProducts.length)
        .toList();
  }
}
