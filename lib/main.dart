import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'pages/login_page.dart';
import 'pages/second_page.dart';
import 'pages/third_page.dart';
import 'pages/create_account.dart';

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
        scaffoldBackgroundColor: const Color(0xFF0389A6),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFDEA74D),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color(0xFFDEA74D)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFDEA74D),
              width: 1,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LoginPage(),
        '/second': (context) => const SecondPage(),
        '/third': (context) => const ThirdPage(),
        '/new-account': (context) => const CreateAccount(),
      },
    );
  }
}
