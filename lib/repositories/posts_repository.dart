import 'package:f290_pi_5/models/posts_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostsRepository {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> create(PostsModel post) async {
    return await supabase.from('posts').insert({
      'description': post.description,
      'coordinates': post.coordinates,
      'user_id': post.userId,
      'title': post.title,
      'category_id': post.categoryId,
      'solved': post.solved,
      'avatar': post.avatar,
    }).select('id');
  }

  Future<List<Map<String, dynamic>>> update(PostsModel post) async {
    return await supabase
        .from('posts')
        .update({
          'description': post.description,
          'coordinates': post.coordinates,
          'user_id': post.userId,
          'title': post.title,
          'category_id': post.categoryId,
          'solved': post.solved,
          'avatar': post.avatar,
        })
        .eq('id', post.id)
        .select('id');
  }

  Future<List<PostsModel>> findAll() async {
    final response = await supabase
        .from('posts')
        .select('*, users(*), post_likes(*), comments(*)')
        .order('id', ascending: false);

    final posts =
        response.map<PostsModel>((p) => PostsModel.fromJson(p)).toList();

    return posts;
  }

  Future<List<PostsModel>> findOne(int id) async {
    final response = await supabase
        .from('posts')
        .select('*, users(*), post_likes(*), comments(*)')
        .eq('id', id);

    final posts =
        response.map<PostsModel>((p) => PostsModel.fromJson(p)).toList();

    return posts;
  }

  void delete(int id) async {
    await supabase.from('posts').delete().eq('id', id);
  }
}
