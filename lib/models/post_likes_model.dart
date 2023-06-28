class PostLikesModel {
  int id = 0;
  int userId = 0;
  int postId = 0;
  String? insertedAt;
  String? updatedAt;

  PostLikesModel({
    required this.id,
    required this.userId,
    required this.postId,
    this.insertedAt,
    this.updatedAt,
  });

  PostLikesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    postId = json['post_id'];
    insertedAt = json['inserted_at'];
    updatedAt = json['updated_at'];
  }
}
