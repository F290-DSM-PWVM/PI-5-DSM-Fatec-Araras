import 'package:f290_pi_5/models/posts_model.dart';
import 'package:f290_pi_5/models/users_model.dart';

class CommentsModel {
  int id = 0;
  String description = '';
  int userId = 0;
  int postId = 0;
  String media = '';
  int parentId = 0;
  String? insertedAt;
  String? updatedAt;
  UsersModel? user;
  PostsModel? post;

  CommentsModel({
    required this.id,
    required this.description,
    required this.userId,
    required this.postId,
    required this.media,
    required this.parentId,
    this.insertedAt,
    this.updatedAt,
    this.user,
    this.post,
  });

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    userId = json['user_id'];
    postId = json['post_id'];
    media = json['media'];
    parentId = json['parent_id'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }

  String commentsValidations() {
    if (description.isEmpty) {
      return 'O comentário não deve ser vazio';
    }

    return '';
  }
}
