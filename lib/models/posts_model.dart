import 'package:f290_pi_5/models/categories_model.dart';
import 'package:f290_pi_5/models/users_model.dart';

class PostsModel {
  int id = 0;
  String description = '';
  String coordinates = '';
  int userId = 0;
  String title = '';
  int categoryId = 0;
  bool solved = false;
  String avatar = '';
  String? insertedAt;
  String? updatedAt;
  UsersModel? user;
  CategoriesModel? category;

  PostsModel({
    required this.id,
    required this.description,
    required this.coordinates,
    required this.userId,
    required this.title,
    required this.categoryId,
    required this.solved,
    required this.avatar,
    this.insertedAt,
    this.updatedAt,
    this.user,
    this.category,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    coordinates = json['coordinates'];
    userId = json['user_id'];
    title = json['title'];
    categoryId = json['category_id'];
    solved = json['solved'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  String postValidations() {
    if (description.isEmpty) {
      return 'O post deve ser preenchido';
    }

    return '';
  }
}
