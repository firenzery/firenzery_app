import 'package:firenzery/app/pages/request_detail/request_detail.page.dart';
import 'package:firenzery/app/pages/requests/components/request_card.dart';
import 'package:firenzery/app/pages/requests/requests.controller.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:firenzery/app/viewmodels/user.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  late final SaleViewModel saleViewModel;
  late final UserViewModel userViewModel;
  late final RequestController controller;

  @override
  void initState() {
    controller = context.read<RequestController>();
    saleViewModel = Provider.of<SaleViewModel>(context, listen: false);
    userViewModel = Provider.of<UserViewModel>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(milliseconds: 500),
        () => controller.getSales(
            userViewModel.userModel.idClient!, saleViewModel));

    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Compras',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<SaleViewModel>(
        builder: (context, saleViewModel, Widget? child) => ListView.builder(
          itemCount: saleViewModel.listSalesModel.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(defaultPadding / 2),
                horizontal: getProportionateScreenWidth(defaultPadding)),
            child: RequestCard(
              sale: saleViewModel.listSalesModel[index],
              press: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RequestDetailPage(
                            sale: saleViewModel.listSalesModel[index])));
              },
            ),
          ),
        ),
      ),
    );
  }
}
