import 'dart:convert';

import 'package:contact/models/post.dart';
import 'package:http/http.dart' as http;

class PostApi {
  Future<List<Post>?> getPost() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;

      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
