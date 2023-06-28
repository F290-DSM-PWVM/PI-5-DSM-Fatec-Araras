import 'package:f290_pi_5/models/posts_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:f290_pi_5/widgets/comment_item.dart';
import 'package:f290_pi_5/widgets/post_item.dart';

class ViewPostPage extends StatefulWidget {
  const ViewPostPage({Key? key, required this.postModel}) : super(key: key);

  final PostsModel postModel;

  @override
  State<ViewPostPage> createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Bulletin Board'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('placeholder.jpg'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            ListTile(
              title: FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  final sharedPreferences = snapshot.data;
                  final userName =
                      sharedPreferences?.getString('user_name') ?? '';
                  return Text(
                    userName,
                  ); // Exibe o nome do usuário obtido do SharedPreferences
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Configurações'),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Adicione aqui o código para lidar com a opção "Configurações"
              },
            ),
            ListTile(
              title: const Text('Sair'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                _logout(context); // Chama a função para fazer logout do usuário
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                PostItem(
                  feedModel: widget.postModel,
                ),
                const Divider(),
                const CommentItem(
                  commentModel: {
                    'user': 'Luis Vinicius',
                    'comment':
                        'Muito interessante essa postagem, espero que as autoridades tomem providencia.',
                  },
                ),
                // const CommentItem(
                //   commentModel: {
                //     'user': 'Jane Smith',
                //     'comment': 'Another comment.',
                //   },
                // ),
                // const CommentItem(
                //   commentModel: {
                //     'user': 'Mike Johnson',
                //     'comment': 'Nice post!',
                //   },
                // ),
                // const CommentItem(
                //   commentModel: {
                //     'user': 'Emily Davis',
                //     'comment': 'Great content.',
                //   },
                // ),
                // const CommentItem(
                //   commentModel: {
                //     'user': 'David Wilson',
                //     'comment': 'I agree with you.',
                //   },
                // ),
                // const CommentItem(
                //   commentModel: {
                //     'user': 'Sarah Thompson',
                //     'comment': 'Thanks for sharing.',
                //   },
                // ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: Border.all(
                color: const Color(
                  0xFFC7C7C7,
                ), // Cor da borda quando não estiver em foco
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Escreva seu comentário',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Color(
                              0xFFC7C7C7), // Cor da borda quando não estiver em foco
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors
                              .orange, // Cor da borda quando estiver em foco (laranja)
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Ação do botão "send"
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Color(0xFF303030), // Cor do ícone branco
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _logout(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('user_email');
  preferences.remove('user_name');
  preferences.remove('user_id');
  Navigator.pushNamed(
    context,
    '/',
  ); // Navega de volta para a tela inicial ("/") após fazer logout
}
