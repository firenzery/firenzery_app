import 'package:firenzery/app/components/buttom_navigation.component.dart';
import 'package:firenzery/app/models/sale.model.dart';
import 'package:firenzery/app/pages/login/components/alertDialog.dart';
import 'package:firenzery/app/pages/request_detail/request_detail.controller.dart';
import 'package:firenzery/app/pages/requests/requests.controller.dart';
import 'package:firenzery/app/viewmodels/adress.viewmodel.dart';
import 'package:firenzery/app/viewmodels/sale.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:firenzery/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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

  bool alterState = false;

  final RequestController requestController = RequestController();

  @override
  void initState() {
    controller = context.read<RequestDetailController>();
    saleViewModel = Provider.of<SaleViewModel>(context, listen: false);
    adressViewModel = Provider.of<AdressViewModel>(context, listen: false);

    controller.responseStateSale = ResponseStateSaleEnum.idle;

    controller.addListener(() {
      if (controller.responseStateSale == ResponseStateSaleEnum.success) {
        if (alterState) {
          Future.delayed(
              const Duration(milliseconds: 500),
              () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RequestDetailPage(sale: widget.sale))));
        }
      } else if (controller.responseStateSale == ResponseStateSaleEnum.error) {
        Future.delayed(
            const Duration(milliseconds: 500),
            () => showAlertDialog(
                context,
                'Entre em contato com o administrador.',
                'Erro ao cancelar a compra.'));
      }
    });

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
        title: Text('#${widget.sale.idSale}'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding, horizontal: defaultPadding / 1.5),
          child: Consumer<SaleViewModel>(
            builder: (context, saleViewModel, Widget? child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            getProportionateScreenWidth(defaultPadding / 1.5),
                        vertical:
                            getProportionateScreenHeight(defaultPadding / 2)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: getProportionateScreenHeight(10),
                            decoration: BoxDecoration(
                              color: requestController
                                  .setColorState(widget.sale.state!),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
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
                          vertical: getProportionateScreenHeight(3)),
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
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
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
                                      "R\$${saleViewModel.productsBySale[index].price}",
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
                  height: getProportionateScreenHeight(120),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Resumo de valores',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: getProportionateScreenHeight(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text("R\$${widget.sale.total}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Frete:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            const Text("R\$0.00",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total:",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text("R\$${widget.sale.total}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Container(
                  height: getProportionateScreenHeight(80),
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
                              'Metodo de pagamento',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
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
                  height: getProportionateScreenHeight(80),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
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
                const SizedBox(height: defaultPadding),
                Container(
                  height: getProportionateScreenHeight(100),
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
                              'Avalie seu pedido',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              maxLines: 2,
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            RatingBar.builder(
                              initialRating: widget.sale.rating!,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                if (rating != widget.sale.rating) {
                                  widget.sale.rating = rating;
                                  controller.alterSale(
                                      saleViewModel, widget.sale);
                                }
                              },
                            )
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
      ),
      bottomNavigationBar: widget.sale.state ==
              controller.getStateByEnum(StateSaleEnum.pending)
          ? Container(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10),
                horizontal: getProportionateScreenWidth(30),
              ),
              // height: 174,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -15),
                    blurRadius: 20,
                    color: const Color(0xFFDADADA).withOpacity(0.15),
                  )
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(190),
                          child: ElevatedButton(
                            onPressed: () {
                              alterState = true;
                              widget.sale.state = controller
                                  .getStateByEnum(StateSaleEnum.canceled);
                              controller.alterSale(saleViewModel, widget.sale);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: const StadiumBorder()),
                            child: const Text("Cancelar"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
    );
  }
}