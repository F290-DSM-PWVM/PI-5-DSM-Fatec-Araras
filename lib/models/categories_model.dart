class CategoriesModel {
  int id = 0;
  String name = '';
  String? icon = '';

  CategoriesModel({
    required this.id,
    required this.name,
    this.icon,
  });
}