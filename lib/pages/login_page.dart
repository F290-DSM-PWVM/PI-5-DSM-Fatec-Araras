import 'package:flutter/material.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Page'),
//       ),
//       body: SizedBox.expand(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             FilledButton.icon(
//               onPressed: () {
//                 // Navegação com rota nomeada para a segunda página
//                 Navigator.pushNamed(context, '/second');
//               },
//               icon: const Icon(Icons.arrow_forward),
//               label: const Text('Ir para SecondPage'),
//             ),
//             FilledButton.icon(
//               onPressed: () {
//                 // Navegação com rota nomeada para a terceira página
//                 Navigator.pushNamed(context, '/third');
//               },
//               icon: const Icon(Icons.arrow_forward),
//               label: const Text('Ir para ThirdPage'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Login Page'),
            FilledButton.icon(
              onPressed: () {
                // Navegação com rota nomeada para a segunda página
                Navigator.pushNamed(context, '/second');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir para SecondPage'),
            ),
            FilledButton.icon(
              onPressed: () {
                // Navegação com rota nomeada para a terceira página
                Navigator.pushNamed(context, '/third');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir para ThirdPage'),
            ),
            FilledButton.icon(
              onPressed: () {
                // Navegação com rota nomeada para a terceira página
                Navigator.pushNamed(context, '/new-account');
              },
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Ir para Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
