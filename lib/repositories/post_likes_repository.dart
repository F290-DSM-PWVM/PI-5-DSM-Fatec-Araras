import 'package:f290_pi_5/models/post_likes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostLikesRepository {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> create(PostLikesModel like) async {
    return await supabase.from('post_likes').insert({
      'user_id': like.userId,
      'post_id': like.postId,
    }).select('id');
  }

  Future<List<PostLikesModel>> findPerPost(int postId) async {
    final response =
        await supabase.from('post_likes').select('*').eq('post_id', postId);

    final likes = response
        .map<PostLikesModel>((l) => PostLikesModel.fromJson(l))
        .toList();

    return likes;
  }

  void dislike(int userId, int postId) async {
    await supabase
        .from('post_likes')
        .delete()
        .match({'user_id': userId, 'post_id': postId});
  }

  void delete(int id) async {
    await supabase.from('post_likes').delete().eq('id', id);
  }
}
