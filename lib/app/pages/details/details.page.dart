import 'package:firenzery/app/models/product.model.dart';
import 'package:firenzery/app/viewmodels/products.viewmodel.dart';
import 'package:firenzery/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quantity_input/quantity_input.dart';

class DetailsPage extends StatefulWidget {
  ProductModel product;

  DetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatailsPageState();
}

class _DatailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    ProductsViewModel productsViewModel =
        Provider.of<ProductsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          const SizedBox(height: defaultPadding * 3),
          Image.network(
            widget.product.image!,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding * 1.5),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(defaultPadding,
                  defaultPadding * 2, defaultPadding, defaultPadding),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(defaultBorderRadius * 3),
                  topRight: Radius.circular(defaultBorderRadius * 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      const SizedBox(width: defaultPadding),
                      Text(
                        "R\$${widget.product.price}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Text(widget.product.description!),
                  ),
                  const SizedBox(height: defaultPadding * 8),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantityInput(
                            inputWidth: 30,
                            buttonColor: primaryColor,
                            value: widget.product.quantity,
                            onChanged: (value) {
                              setState(() => widget.product.quantity =
                                  int.parse(value.replaceAll(',', '')));
                            }),
                        SizedBox(
                          width: 200,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              productsViewModel.addProductCart(widget.product);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: primaryColor,
                                shape: const StadiumBorder()),
                            child: const Text("Adicionar ao Carrinho"),
                          ),
                        ),
                      ])
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
