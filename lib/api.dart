import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'models.dart';

class Api {
  static final String baseUrl = "https://jsonplaceholder.typicode.com";

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(baseUrl + "/posts");
    final responseJson = json.decode(response.body);

    return (responseJson as List)
        .map((p) => Post.fromJson(p as Map<String, dynamic>))
        .toList();
  }
}
