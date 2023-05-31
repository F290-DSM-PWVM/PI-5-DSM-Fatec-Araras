import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _textFieldController = TextEditingController();
  String selectedCategory = 'Categoria';
  List<String> categories = [
    'Categoria',
    'Água e esgoto',
    'Animais',
    'categoria 4',
  ];

  //   'Água e esgoto',
  //   'Animais',
  //   'Coleta de lixo',
  //   'Educação',
  //   'Iluminação',
  //   'Meio-ambiente',
  //   'Saúde',
  //   'Serviço público',
  //   'Transporte e vias públicas',
  // ];

  // Map<String, IconData> categoryIcons = {
  //   'Água e esgoto': Icons.book,
  //   'Animais': Icons.book,
  //   'Coleta de lixo': Icons.book,
  //   'Educação': Icons.book,
  //   'Iluminação': Icons.book,
  //   'Meio-ambiente': Icons.book,
  //   'Saúde': Icons.book,
  //   'Serviço público': Icons.book,
  //   'Transporte e vias públicas': Icons.book,
  // };

  Map<String, IconData> categoryIcons = {
    'Categoria': Icons.category,
    'Água e esgoto': Icons.account_circle,
    'Animais': Icons.camera,
    'categoria 4': Icons.book,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicações'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
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
                    'Criar Publicações',
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
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF1F1F1),
                              border: Border.all(
                                color: const Color(0xFFC7C7C7),
                                width: 1,
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Lógica para abrir a tela de seleção de imagem
                              },
                              icon: const Icon(
                                Icons.add_photo_alternate,
                                color: Color(0xFF6F6F6F),
                                size: 50,
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFC7C7C7),
                                  width: 1,
                                ),
                              ),
                              child: DropdownButton<String>(
                                value: selectedCategory,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedCategory = newValue;
                                    });
                                  }
                                },
                                items: categories.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          Icon(
                                            categoryIcons[value],
                                            color: const Color(0xFF6F6F6F),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(value),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      TextField(
                        controller: _textFieldController,
                        maxLines: 360 ~/ 20, // Estimativa de 20px por linha
                        decoration: InputDecoration(
                          hintText: 'Digite algo...',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFC7C7C7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF1F1F1),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Publicar'),
                        ),
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
}
