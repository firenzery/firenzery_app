class PopularProductsResponse {
  int? idProduct;
  int? quantity;

  PopularProductsResponse({this.idProduct, this.quantity});

  PopularProductsResponse.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProduct'] = idProduct;
    data['quantity'] = quantity;
    return data;
  }
}
