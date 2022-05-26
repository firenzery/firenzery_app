class ProductModel {
  String? image, name, description;
  double? price;
  int? type;

  ProductModel({this.image, this.name, this.price, this.type});

  ProductModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    price = json['price'].toDouble();
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['type'] = type;
    return data;
  }
}
