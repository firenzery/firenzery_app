import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/pages/request_detail/request_detail.controller.dart';
import 'package:firenzery/app/pages/requests/requests.controller.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class RequestDetailPage extends StatefulWidget {
  final SaleModel sale;
  const RequestDetailPage({required this.sale, Key? key}) : super(key: key);

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
  late final RequestDetailController controller;
  late final SaleViewModel saleViewModel;
  late final AdressViewModel adressViewModel;

  final RequestController requestController = RequestController();

  @override
  void initState() {
    controller = context.read<RequestDetailController>();
    saleViewModel = Provider.of<SaleViewModel>(context, listen: false);
    adressViewModel = Provider.of<AdressViewModel>(context, listen: false);

    Future.delayed(
        const Duration(milliseconds: 500),
        () =>
            controller.getProductsBySaleId(saleViewModel, widget.sale.idSale!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Detalhes'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding, horizontal: defaultPadding / 1.5),
        child: Consumer<SaleViewModel>(
          builder: (context, saleViewModel, Widget? child) => Column(
            children: [
              Container(
                height: saleViewModel.productsBySale.length >= 5
                    ? 380
                    : saleViewModel.productsBySale.length * 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: saleViewModel.productsBySale.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenWidth(3)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Image.network(
                              saleViewModel.productsBySale[index].image!,
                              height: 132,
                              width: 132,
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: primaryColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              saleViewModel.productsBySale[index].name!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            const SizedBox(height: 10),
                            Text.rich(
                              TextSpan(
                                text:
                                    "\$${saleViewModel.productsBySale[index].price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor),
                                children: [
                                  TextSpan(
                                      text:
                                          "  x${saleViewModel.productsBySale[index].quantity}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Container(
                height: getProportionateScreenWidth(75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Metodo de Pagamento',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          SizedBox(height: getProportionateScreenWidth(5)),
                          Text.rich(
                            TextSpan(
                              text: requestController
                                  .setPayment(widget.sale.payment!),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Container(
                height: getProportionateScreenWidth(75),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Endereço',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: 2,
                          ),
                          SizedBox(height: getProportionateScreenWidth(5)),
                          Text.rich(
                            TextSpan(
                              text:
                                  "${adressViewModel.adressModel.apartment}${adressViewModel.adressModel.block} GRUPO ${adressViewModel.adressModel.group}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
