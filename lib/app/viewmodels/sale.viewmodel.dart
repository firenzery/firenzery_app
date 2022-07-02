import 'package:firenzery/app/interfaces/sales.interface.dart';
import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/services/remote/sales.service.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

class SaleViewModel extends ChangeNotifier {
  ISales service = SalesService();

  SaleModel saleRequest = SaleModel();
  List<SaleModel> listSalesModel = [];
  List<ProductModel> productsBySale = [];

  getProductsBySaleId(int idSale) async {
    try {
      var products = await service.getProductsBySaleId(idSale);

      List productsBody = convert.jsonDecode(products.body);

      productsBySale =
          productsBody.map((data) => ProductModel.fromJson(data)).toList();

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  getSalesByUser(int idClient) async {
    try {
      var sales = await service.getSalesByUser(idClient);

      List salesBody = convert.jsonDecode(sales.body);

      listSalesModel =
          salesBody.map((data) => SaleModel.fromJson(data)).toList();

      listSalesModel.sort((a, b) => b.saleDate!.compareTo(a.saleDate!));

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  addSaleByUser(SaleModel sale, List<ProductModel> products) async {
    try {
      var resp = await service.addSaleByUser(sale, products);

      saleRequest = SaleModel.fromJson(convert.jsonDecode(resp.body));

      await getSalesByUser(sale.idClient!);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  alterStateSale(int idSale, int state) async {
    try {
      var resp = await service.alterStateSale(idSale, state);
      notifyListeners();
      return resp;
    } catch (error) {
      rethrow;
    }
  }
}
