class CategoryModel {
  String? icon;
  String? title;
  int? type;

  CategoryModel({this.icon, this.title, this.type});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['type'] = this.type;
    return data;
  }
}
