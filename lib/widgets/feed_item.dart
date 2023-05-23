import 'package:flutter/material.dart';

import '../models/feed_model.dart';
import '../pages/detail_page.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    required this.feedModel,
  });

  final FeedModel feedModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Primeira seção: Dados do usuário - ListTile() -----------------------
        ListTile(
          leading: CircleAvatar(
            backgroundColor:
                Colors.primaries[feedModel.id % Colors.primaries.length],
            child: Text('${feedModel.id}'),
          ),
          title: Text(
            feedModel.name,
          ),
          subtitle: Text(feedModel.data),
        ),
        // Final ListTile ------------------------------------------------------

        // Segunda seção: Texto do Post - Text() -------------------------------
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(feedModel.lorem),
        ),
        // Final Text() --------------------------------------------------------

        // Terceira seção: Imagem do Post - Container() com imagem de fundo ----
        Container(
          height: 300,
          margin: const EdgeInsets.only(left: 16, right: 16),
          // Decoração avançada de container
          decoration: BoxDecoration(
            // Bordas arredondadas
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(
              // Ajuste de imagem com base na altura mantendo proporções
              fit: BoxFit.fitHeight,
              image: NetworkImage(feedModel.imageUrl),
            ),
          ),
        ),
        // Final Container()

        // Quarta seção: Barra de Açoes - ButtomBar() --------------------------
        ButtonBar(
          children: [
            TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(height: 200),
                );
              },
              icon: const Icon(Icons.favorite),
              label: Text('${feedModel.likesCounter} Curtir'),
            ),
            TextButton.icon(
              onPressed: () {
                //TODO: Navegar para comentários
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
          ],
        ),
        // Final ButtomBar()
      ],
    );
  }
}
