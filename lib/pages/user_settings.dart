import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    loadUserData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    String? name = prefs.getString('user_name');
    if (email != null) {
      _emailController.text = email;
    }
    if (name != null) {
      _nameController.text = name;
    }
  }

  @override
  Widget build(BuildContext context) {
    var itemsWidth = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações da conta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/feed');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome Completo',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
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
                        return 'Por favor, insira sua senha';
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
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar Senha',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, repita seu nome';
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
                      saveUserData(context);
                    },
                    child: const Text('Salvar'),
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirmação'),
                          content: const Text(
                              'Tem certeza de que deseja apagar sua conta?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Fechar o modal
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop(); // Fechar o modal
                                confirmDeleteAccount(); // Chamar a função de exclusão da conta
                              },
                              child: const Text('Confirmar'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Apagar conta'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirmDeleteAccount() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('user_id');

    await supabase.from('users').delete().eq('id', userId);

    preferences.remove('user_email');
    preferences.remove('user_name');
    preferences.remove('user_id');
    Navigator.pushNamed(context, '/');
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

  Future<void> saveUserData(context) async {
    final email = _emailController.text;
    final name = _nameController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('user_email');
    int? userId = prefs.getInt('user_id');

    if (email.isNotEmpty && email != userEmail) {
      final responseMail =
          await supabase.from('users').select('*').eq('email', email);

      if (responseMail.isNotEmpty) {
        _msgValidacao(
            'O e-mail informado já está sendo utilizado por outro usuário',
            'Falha ao cadastrar');
        return;
      }
    }

    if (name.isEmpty) {
      _msgValidacao('O campo Nome deve ser preenchido', 'Falha ao cadastrar');
      return;
    }

    if (email.isEmpty) {
      _msgValidacao('O campo E-mail deve ser preenchido', 'Falha ao cadastrar');
      _validateEmail(email);
      return;
    }

    if (password != confirmPassword) {
      _msgValidacao(
          'As senhas informadas não correspondem', 'Senhas inválidas');
      return;
    }

    final encryptedPassword = encryptPassword(password);

    await supabase.from('users').update({
      'full_name': name,
      'email': email,
    }).eq('id', userId);

    if (password.isNotEmpty) {
      await supabase
          .from('users')
          .update({'password': encryptedPassword}).eq('id', userId);
    }

    await prefs.setString('user_email', email);
    await prefs.setString('user_name', name);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Dados salvos com sucesso!'),
      ),
    );
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    Navigator.pushNamed(context, '/feed');
  }

  void _validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$',
    );

    if (!emailRegex.hasMatch(email)) {
      _msgValidacao(
          'O campo E-mail não contém um e-mail válido', 'Falha ao cadastrar');
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
