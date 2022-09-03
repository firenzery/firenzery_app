class SaleModel {
  int? idSale;
  int? idClient;
  int? payment;
  int? paymentType;
  int? state;
  double? total;
  String? saleDate;
  double? rating;

  SaleModel(
      {this.idSale,
      this.idClient,
      this.payment,
      this.paymentType,
      this.total,
      this.rating});

  SaleModel.fromJson(Map<String, dynamic> json) {
    idSale = json['idSale'];
    idClient = json['idClient'];
    payment = json['payment'];
    paymentType = json['paymentType'];
    total = json['total'].toDouble();
    state = json['state'];
    saleDate = json['saleDate'];
    rating = json['rating'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSale'] = idSale;
    data['idClient'] = idClient;
    data['payment'] = payment;
    data['paymentType'] = paymentType;
    data['total'] = total;
    data['state'] = state;
    data['rating'] = rating;
    return data;
  }
}
