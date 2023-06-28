import 'package:f290_pi_5/models/posts_model.dart';
import 'package:flutter/material.dart';

import '../../models/feed_model.dart';

class DetailPage extends StatelessWidget {
  // Recebendo o objeto FeedModel pelo construtor
  const DetailPage({super.key, required this.feedModel});

  final PostsModel feedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),

      // Gerando a lista de comentários com base na lista de comentários contidas no objeto
      body: ListView.separated(
        itemCount: 2,
        itemBuilder: (context, index) => ListTile(
          title: const Text(''),
          subtitle: const Text(''),
        ),
        // itemCount: feedModel.comentarios.length,
        // itemBuilder: (context, index) => ListTile(
        //   title: Text(feedModel.comentarios[index]['user']!),
        //   subtitle: Text(feedModel.comentarios[index]['coment']!),
        // ),

        // Separador
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 16, thickness: 1),
      ),
    );
  }
}
