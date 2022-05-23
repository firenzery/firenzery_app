class CategoryModel {
  final String icon, title;
  final int type;

  CategoryModel({required this.icon, required this.title, required this.type});
}

List<CategoryModel> demo_categories = [
  CategoryModel(
      icon: "assets/icons/soda_icon.svg", title: "Refrigerantes", type: 1),
  CategoryModel(
      icon: "assets/icons/soda_icon.svg", title: "Energeticos", type: 2),
  CategoryModel(icon: "assets/icons/soda_icon.svg", title: "Cervejas", type: 3),
  CategoryModel(
      icon: "assets/icons/soda_icon.svg", title: "Destilados", type: 4),
];
