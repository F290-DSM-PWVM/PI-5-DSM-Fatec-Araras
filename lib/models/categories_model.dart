class CategoriesModel {
  int id = 0;
  String name = '';
  String? insertedAt = '';
  String? updatedAt = '';
  String? icon = '';

  CategoriesModel({
    required this.id,
    required this.name,
    this.insertedAt,
    this.updatedAt,
    this.icon,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['inserted_at'] = insertedAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
