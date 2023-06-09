import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login_page.dart';
import 'pages/feed_page.dart';
import 'pages/user_settings.dart';
import 'pages/create_account.dart';
import 'pages/create_post.dart';

void main() {
  Supabase.initialize(
    url: 'https://opzvcrtfywzautcttqtc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9wenZjcnRmeXd6YXV0Y3R0cXRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODMwNjk4NzQsImV4cCI6MTk5ODY0NTg3NH0.ryIUtPCfhd0gbZSxq60HmyAkhjKxuSuTvx2jrQt_MTM',
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

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
        '/user-settings': (context) => const UserSettings(),
        '/new-account': (context) => const CreateAccount(),
        '/create-post': (context) => const CreatePost(),
      },
    );
  }
}
