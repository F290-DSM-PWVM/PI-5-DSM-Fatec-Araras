import 'package:f290_pi_5/models/comments_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsRepository {
  SupabaseClient supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> create(CommentsModel comment) async {
    return await supabase.from('comments').insert({
      'description': comment.description,
      'user_id': comment.userId,
      'post_id': comment.postId,
      'media': comment.media,
      'parent_id': comment.parentId,
    }).select('id');
  }

  Future<List<Map<String, dynamic>>> update(CommentsModel comment) async {
    return await supabase
        .from('comments')
        .update({
          'description': comment.description,
          'user_id': comment.userId,
          'post_id': comment.postId,
          'media': comment.media,
          'parent_id': comment.parentId,
        })
        .eq('id', comment.id)
        .select('id');
  }

  Future<List<CommentsModel>> findPerPost(int postId) async {
    final response =
        await supabase.from('comments').select('*').eq('post_id', postId);

    final comments =
        response.map<CommentsModel>((c) => CommentsModel.fromJson(c)).toList();

    return comments;
  }

  void delete(int id) async {
    await supabase.from('comments').delete().eq('id', id);
  }
}
