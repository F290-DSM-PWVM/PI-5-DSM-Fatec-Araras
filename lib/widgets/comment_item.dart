import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  final Map<String, String> commentModel;

  const CommentItem({
    Key? key,
    required this.commentModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'de ${commentModel['user']}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(
            height: 230, // Altura do retângulo maior
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0), // Cor do retângulo cinza
                    border: Border.all(
                      color: const Color(0xFFE9E0E3), // Cor da borda cinza
                      width: 2, // Espessura da borda (2px)
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      commentModel['comment']!,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, bottom: 16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: IconButton(
                  onPressed: () {
                    // Ação do botão
                  },
                  icon: Icon(
                    Icons.reply,
                    color: Colors.orange, // Cor do ícone laranja
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
