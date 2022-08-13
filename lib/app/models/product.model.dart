class ProductModel {
  int? idProduct;
  String? image, name, description;
  double? price;
  int? type;
  String? datetime;
  int? quantity;

  ProductModel(
      {this.idProduct,
      this.image,
      this.name,
      this.price,
      this.type,
      this.description,
      this.datetime,
      this.quantity});

  ProductModel.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    image = json['image'];
    name = json['name'];
    price = json['price'].toDouble();
    type = json['type'];
    description = json['description'];
    datetime = json['datetime'];
    quantity = 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idProduct'] = idProduct;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['type'] = type;
    data['description'] = description;
    data['dateTime'] = datetime;
    data['quantity'] = quantity;
    return data;
  }
}
