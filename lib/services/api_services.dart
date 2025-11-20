import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:knovator/models/post_model.dart';

class ApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com/posts";

  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl),headers: {"Accept":"application/json"});
    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PostModel.fromJson(json)).toList();
      } catch (e) {throw Exception("Parsing Error: $e");}
    } else {throw Exception("Failed to load posts");}
  }
}
