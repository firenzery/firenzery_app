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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['price'] = this.price;
    data['type'] = this.type;
    return data;
  }
}
