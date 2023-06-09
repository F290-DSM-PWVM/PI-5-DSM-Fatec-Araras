import 'package:f290_pi_5/models/categories_model.dart';
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
  late String selectedCategory;

  final supabase = Supabase.instance.client;

  Map<String, IconData> categoryIcons = {
    'Categoria': Icons.category,
    'Água e esgoto': Icons.account_circle,
    'Animais': Icons.camera,
    'categoria 4': Icons.book,
  };

  @override
  void initState() {
    super.initState();
    selectedCategory = '1';
    getDropdownItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
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
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF1F1F1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFC7C7C7),
                                    width: 1,
                                  ),
                                ),
                                child: FutureBuilder<List<DropdownMenuItem<String>>>(
                                  future: getDropdownItems(),
                                  builder: (BuildContext context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
                                    if (snapshot.hasData) {
                                      return DropdownButton<String>(
                                        value: selectedCategory,
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedCategory = newValue;
                                            });
                                          }
                                        },
                                        items: snapshot.data!,
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text('Erro ao carregar os dados do dropdown');
                                    }
                                    return const CircularProgressIndicator();
                                  },
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
      ),
    );
  }

  Future<List<DropdownMenuItem<String>>> getDropdownItems() async {
    List<CategoriesModel> categories = await categoriesLst();

    List<DropdownMenuItem<String>> dropdownItems = categories.map((category) {
      return DropdownMenuItem<String>(
        value: category.id.toString(),
        child: Row(
          children: [
            // Icon(
            //   category.icon != null ? category.icon! : '',
            //   color: const Color(0xFF6F6F6F),
            // ),
            const SizedBox(width: 8),
            Text(category.name),
          ],
        ),
      );
    }).toList();

    if (selectedCategory == 'Categoria' && dropdownItems.isNotEmpty) {
      selectedCategory = dropdownItems.first.value!;
    }

    return dropdownItems;
  }

  Future<List<CategoriesModel>> categoriesLst() async {
    final response = await supabase.from('categories').select('*');
    final categoriesList = response.data as List<dynamic>;

    return categoriesList
        .map((category) => CategoriesModel(
              id: category['id'] as int,
              name: category['name'] as String,
              // icon: category['icon'] as String?,
            ))
        .toList();
  }
}
