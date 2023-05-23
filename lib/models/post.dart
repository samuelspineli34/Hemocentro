import 'dart:convert';
import '../services/remote_service.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

class Post {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl; // Adicionando a propriedade thumbnailUrl

  Post({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    title: json['title'],
    url: json['url'],
    thumbnailUrl: json['thumbnailUrl']
  );
}
