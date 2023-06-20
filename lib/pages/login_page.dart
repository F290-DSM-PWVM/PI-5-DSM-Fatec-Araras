import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    var itemsWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('../../assets/placeholder.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: itemsWidth,
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Para continuar, informe seu e-mail';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: itemsWidth,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Para continuar, informe sua senha';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40.0,
                  width: itemsWidth,
                  child: ElevatedButton(
                    onPressed: () async {
                      _signIn(context);
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: 'Não possui conta? ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Cadastre-se aqui',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/new-account');
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _msgValidacao(String msg, String msgTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(msgTitle),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    return;
  }

  void _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(email)) {
      _msgValidacao('O campo E-mail não contém um e-mail válido',
          'Falha ao realizar login');
    }
  }

  void _signIn(context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    if (email.isEmpty) {
      _msgValidacao(
          'O campo E-mail deve ser preenchido', 'Falha ao realizar login');
      _validateEmail(email);
      return;
    }

    if (password.isEmpty) {
      _msgValidacao(
          'Ambos campos de senha ser preenchido', 'Falha ao realizar login');
      return;
    }

    final encryptedPassword = encryptPassword(password);

    final response = await supabase
        .from('users')
        .select('*')
        .match({'email': email, 'password': encryptedPassword})
        .limit(1)
        .single();

    if (response.isNotEmpty) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user_email', email);
      preferences.setString('user_name', response['full_name'] ?? '');
      preferences.setInt('user_id', response['id'] ?? '');
      Navigator.pushNamed(context, '/feed');
    } else {
      _msgValidacao(
          'O e-mail e/ou senha não correspondem', 'Falha ao realizar login');
    }
  }

  String encryptPassword(String password) {
    // Implemente sua lógica de criptografia da senha aqui
    // Pode ser usado algum algoritmo de hash, como bcrypt ou PBKDF2
    // Certifique-se de usar uma biblioteca de criptografia confiável
    // Neste exemplo, vamos usar uma criptografia simples para fins de demonstração
    return password
        .toUpperCase(); // Criptografia simples: converter para maiúsculas
  }
}
