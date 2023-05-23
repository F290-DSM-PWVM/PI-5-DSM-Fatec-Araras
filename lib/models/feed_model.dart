import 'package:faker/faker.dart';
import 'package:intl/intl.dart';

class FeedModel {
  static final faker = Faker();

  int id = faker.randomGenerator.integer(200);
  String name = faker.person.name();
  String data = DateFormat.yMd()
      .add_jms()
      .format(faker.date.dateTime(maxYear: 2023, minYear: 2019));
  String lorem = faker.lorem.sentences(5).join(' ');
  String imageUrl =
      faker.image.image(width: 680, keywords: ['people'], random: true);
  int likesCounter = faker.randomGenerator.integer(25);

  // Geração de lista de comentários para a tela de detalhes
  List<Map<String, String>> comentarios = List.generate(
      faker.randomGenerator.integer(10, min: 1),
      (index) => {
            'user': faker.person.name(),
            'coment': faker.lorem
                .sentences(faker.randomGenerator.integer(5, min: 1))
                .join('')
          });
}
