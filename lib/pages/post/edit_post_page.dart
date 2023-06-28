import 'dart:io';
import 'dart:convert';

import 'package:f290_pi_5/models/categories_model.dart';
import 'package:f290_pi_5/models/posts_model.dart';
import 'package:f290_pi_5/repositories/categories_repository.dart';
import 'package:f290_pi_5/repositories/posts_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({Key? key, required this.postModel}) : super(key: key);

  final PostsModel postModel;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  late TextEditingController _textFieldController =
      TextEditingController(text: widget.postModel.description);
  late String selectedCategory;

  File? selectedImage;
  PostsRepository repository = PostsRepository();

  @override
  void initState() {
    super.initState();
    getDropdownItems();
    selectedCategory = widget.postModel.categoryId.toString();
    _loadImage().then((file) {
      setState(() {
        selectedImage = file;
      });
    });
  }

  Future<File?> _loadImage() async {
    final decodedBytes = base64Decode(widget.postModel.avatar);
    final directory = await getApplicationDocumentsDirectory();
    File fileImg = File('${directory.path}/testImage.png');
    fileImg.writeAsBytesSync(List.from(decodedBytes));

    return fileImg;
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
                      'Editar Publicação',
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
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Selecione uma opção'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.photo_library),
                                              title: const Text('Galeria'),
                                              onTap: () {
                                                _chooseImage(
                                                  ImageSource.gallery,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.camera_alt),
                                              title: const Text('Câmera'),
                                              onTap: () {
                                                _chooseImage(
                                                  ImageSource.camera,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: selectedImage != null
                                    ? Image.file(
                                        selectedImage!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
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
                                child: FutureBuilder<
                                    List<DropdownMenuItem<String>>>(
                                  future: getDropdownItems(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<
                                              List<DropdownMenuItem<String>>>
                                          snapshot) {
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
                                      return const Text(
                                          'Erro ao carregar os dados do dropdown');
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
                            hintText: 'O que está acontecendo?',
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
                            onPressed: () async {
                              _submitPost(context);
                            },
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

  void _LoadData(int id) async {
    List<PostsModel> post = await repository.findOne(id);
    final bytes = base64Decode(post[0].avatar);

    setState(() {
      _textFieldController = TextEditingController(text: post[0].description);
      selectedCategory = post[0].categoryId.toString();
    });
  }

  Future<List<DropdownMenuItem<String>>> getDropdownItems() async {
    final categoriesRepository = CategoriesRepository();
    List<CategoriesModel> categories = await categoriesRepository.findAll();

    List<DropdownMenuItem<String>> dropdownItems = categories.map((category) {
      return DropdownMenuItem<String>(
        value: category.id.toString(),
        child: Row(
          children: [
            SizedBox(
              width: 150, // Defina a largura desejada
              child: Text(
                category.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }).toList();

    if (selectedCategory == 'Categoria' && dropdownItems.isNotEmpty) {
      selectedCategory = dropdownItems.first.value!;
    }

    return dropdownItems;
  }

  void _chooseImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

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

  void _submitPost(context) async {
    final text = _textFieldController.text;
    final category = int.parse(selectedCategory);
    String base64Image = '';

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('user_id') ?? 0;

    if (selectedImage != null) {
      List<int> imageBytes = await selectedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }

    PostsModel post = PostsModel(
      id: widget.postModel.id,
      description: text,
      categoryId: category,
      userId: userId,
      avatar: base64Image,
      coordinates: '',
      solved: false,
      title: '',
    );

    String validations = post.postValidations();

    if (validations.length > 1) {
      _msgValidation(
        validations,
        'Falha ao editar post',
      );
      return;
    }

    final response = await repository.update(post);

    if (response.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('O Post foi atualizado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/feed');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: const Text('Falha na edição de registro!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
