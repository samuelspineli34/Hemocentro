import '../models/post.dart';
import '../api_keys.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RemoteService
{
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://newsapi.org/v2/top-headlines?country=br&category=science&apiKey=a3329cad05114eadbe45299a17945558');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var articles = jsonResponse['articles'] as List<dynamic>;

      List<Post> posts = articles.map((json) => Post.fromJson(json)).toList();

      return posts;
    }

    return null;
  }
}