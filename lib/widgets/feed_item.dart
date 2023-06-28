import 'package:f290_pi_5/models/post_likes_model.dart';
import 'package:f290_pi_5/models/posts_model.dart';
import 'package:f290_pi_5/repositories/post_likes_repository.dart';
import 'package:f290_pi_5/repositories/posts_repository.dart';
import 'package:f290_pi_5/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FeedItem extends StatelessWidget {
  const FeedItem({
    Key? key,
    required this.postsModel,
    required this.userId,
    required this.repository,
  }) : super(key: key);

  final PostsModel postsModel;
  final int userId;
  final PostsRepository repository;
  String get timeagoFormatted {
    DateTime dateTime = DateTime.parse(postsModel.insertedAt!);
    return timeago.format(dateTime, locale: 'en_short');
  }

  void _openImageFullScreen(BuildContext context) {
    final bytes = base64Decode(postsModel.avatar);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: bytes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(postsModel.avatar);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  'de ${postsModel.user?.fullName}',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 5),
                Text(timeagoFormatted),
                if (userId == postsModel.userId) ...[
                  const Spacer(),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'editar') {
                        Navigator.pushNamed(
                          context,
                          '/edit-post',
                          arguments: <String, PostsModel>{
                            'postModel': postsModel
                          },
                        );
                      } else if (value == 'excluir') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirmação'),
                              content: const Text('Deseja excluir o post?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    repository.delete(postsModel.id);
                                    //Navigator.of(context).pop();
                                    Navigator.pushNamed(context, '/feed');
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'editar',
                        child: Text('Editar'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'excluir',
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(postsModel.description),
          ),
          InkWell(
            onTap: () => _openImageFullScreen(context),
            child: Container(
              height: 400,
              margin: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: MemoryImage(bytes),
                ),
              ),
              child: Stack(
                children: const [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.search,
                      color: Colors.orange,
                      size: 80,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextButton.icon(
                  onPressed: () async {
                    List<PostLikesModel>? likes =
                        postsModel.postLikes ?? List.empty();

                    bool alreadyLiked = await _checkUserLiked(likes);

                    if (alreadyLiked) {
                      _likePost(postsModel.id);
                    } else {
                      _unlikePost(postsModel.id);
                    }
                  },
                  icon: const Icon(Icons.arrow_circle_up),
                  label: Text('${postsModel.postLikes?.length} Curtidas'),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/view-post',
                      arguments: <String, PostsModel>{'postModel': postsModel},
                    );
                  },
                  icon: const Icon(Icons.chat_bubble),
                  label: const Text('Comentar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _checkUserLiked(List<PostLikesModel> likes) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('user_id') ?? 0;

    return likes.any((like) => like.userId == userId);
  }

  void _likePost(int postId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('user_id') ?? 0;
    PostLikesRepository likesRepository = PostLikesRepository();

    PostLikesModel like = PostLikesModel(id: 0, userId: userId, postId: postId);
    await likesRepository.create(like);
  }

  void _unlikePost(int postId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('user_id') ?? 0;
    PostLikesRepository likesRepository = PostLikesRepository();

    likesRepository.dislike(userId, postId);
  }
}
