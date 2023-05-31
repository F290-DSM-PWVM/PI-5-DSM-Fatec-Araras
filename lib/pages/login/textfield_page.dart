import 'package:flutter/material.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({super.key});

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Hello',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Hello',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
            ),
          ],
        )),
      ),
    );
  }
}
