import 'package:f290_pi_5/models/posts_model.dart';
import 'package:f290_pi_5/repositories/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/feed_item.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  PostsRepository postsRepository = PostsRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<PostsModel> posts = List.empty();
  int userId = 0;

  @override
  void initState() {
    super.initState();
    loadPosts();
    loadUserId();
  }

  Future<void> loadPosts() async {
    final fetchedPosts = await postsRepository.findAll();
    setState(() {
      posts = fetchedPosts;
    });
  }

  Future<void> loadUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getInt('user_id') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Bulletin Board'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(Icons.search),
        //   ),
        // ],
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
                    image: AssetImage('assets/images/placeholder.jpg'),
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
                  return Text(userName);
                },
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Configurações'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pushNamed(context, '/user-settings');
              },
            ),
            ListTile(
              title: const Text('Sair'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                _logout(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 5,
                    height: 5,
                    color: Colors.black,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
                Text(
                  'Publicações',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 5,
                    height: 5,
                    color: Colors.black,
                    indent: 16,
                    endIndent: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return FeedItem(
                  postsModel: posts[index],
                  userId: userId,
                  repository: postsRepository,
                );
              },
              itemCount: posts.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create-post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void _logout(context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.remove('user_email');
  preferences.remove('user_name');
  preferences.remove('user_id');
  Navigator.pushNamed(context, '/');
}
