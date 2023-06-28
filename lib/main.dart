import 'package:f290_pi_5/pages/post/edit_post_page.dart';
import 'package:f290_pi_5/pages/post/view_post_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'pages/login/login_page.dart';
import 'pages/feed/feed_page.dart';
import 'pages/user/user_settings_page.dart';
import 'pages/user/create_account_page.dart';
import 'pages/post/create_post_page.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final supabaseUrl = dotenv.env['SUPABASE_URL']!;
  final supabaseKey = dotenv.env['SUPABASE_KEY']!;

  WidgetsFlutterBinding.ensureInitialized();
  Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange,
          accentColor: const Color(0xFF0389A6),
        ),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/feed': (context) => const FeedPage(),
        '/user-settings': (context) => const UserSettingsPage(),
        '/new-account': (context) => const CreateAccountPage(),
        '/create-post': (context) => const CreatePostPage(),
        '/edit-post': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return EditPostPage(postModel: args['postModel']);
        },
        '/view-post': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map;
          return ViewPostPage(postModel: args['postModel']);
        }
      },
    );
  }
}
