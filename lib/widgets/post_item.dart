import 'package:f290_pi_5/models/posts_model.dart';
import 'package:f290_pi_5/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert';

class PostItem extends StatelessWidget {
  const PostItem({
    Key? key,
    required this.feedModel,
  }) : super(key: key);

  final PostsModel feedModel;

  String get timeagoFormatted {
    DateTime dateTime = DateTime.now().subtract(const Duration(minutes: 15));
    return timeago.format(dateTime, locale: 'en_short');
  }

  void _openImageFullScreen(BuildContext context) {
    final bytes = base64Decode(feedModel.avatar);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: bytes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(feedModel.avatar);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  'de ${feedModel.user?.fullName}',
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
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(feedModel.description),
          ),
          InkWell(
            onTap: () => _openImageFullScreen(context),
            child: Container(
              height: 400,
              margin: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 24), // Adicionando o padding inferior de 24px
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: MemoryImage(bytes),
                ),
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(height: 200),
                    );
                  },
                  icon: const Icon(Icons.arrow_circle_up),
                  label: Text('${feedModel.postLikes?.length} Curtidas'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
