import 'package:f290_pi_5/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../models/feed_model.dart';
import '../pages/feed/detail_page.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    Key? key,
    required this.feedModel,
  }) : super(key: key);

  final FeedModel feedModel;

  String get timeagoFormatted {
    // DateTime dateTime = DateTime.parse(feedModel.data);
    DateTime dateTime = DateTime.now().subtract(const Duration(minutes: 15));
    return timeago.format(dateTime, locale: 'en_short');
  }

  void _openImageFullScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: feedModel.imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  'de ${feedModel.name}',
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
            child: Text(feedModel.lorem),
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
                  image: NetworkImage(feedModel.imageUrl),
                ),
              ),
              child: const Stack(
                children: [
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
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(height: 200),
                    );
                  },
                  icon: const Icon(Icons.arrow_circle_up),
                  label: Text('${feedModel.likesCounter} Curtidas'),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(feedModel: feedModel),
                      ),
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
}
