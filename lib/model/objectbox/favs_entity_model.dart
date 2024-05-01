import 'package:objectbox/objectbox.dart';

@Entity()
class FavsEntityModel {
  @Id()
  int id = 0;
  String author;
  String title;
  String description;
  String urlToImage;
  DateTime publishedAt;
  String content;

  FavsEntityModel({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
}
