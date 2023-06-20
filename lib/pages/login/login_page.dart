import 'package:f290_pi_5/models/login_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/users_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  void _msgValidation(String msg, String msgTitle) {
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

  void _signIn(context) async {
    final email = _emailController.text;
    final password = _passwordController.text;

    LoginModel login = LoginModel(email: email, password: password);

    String validations = login.loginValidations();

    if (validations.length > 1) {
      _msgValidation(
        validations,
        'Falha ao realizar login',
      );
      return;
    }

    login.encryptPassword();

    var userRepository = UsersRepository();

    final user = await userRepository.findAuthenticatedUser(login);

    if (user != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('user_email', email);
      preferences.setString('user_name', user.fullName);
      preferences.setInt('user_id', user.id);
      Navigator.pushNamed(context, '/feed');
    } else {
      _msgValidation(
          'O e-mail e/ou senha não correspondem', 'Falha ao realizar login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemsWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      body: Container(
        child: Center(
          child: SingleChildScrollView(
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
                          image: AssetImage('assets/images/placeholder.jpg'),
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
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Cadastre-se aqui',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              color: Colors.black,
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
        ),
      ),
    );
  }
}
