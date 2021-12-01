import 'dart:convert';
import 'post_model.dart';
import 'package:http/http.dart';

class HttpService {
  final String postsUrl = "https://retoolapi.dev/oEP796/data";

  Future<void> deletePost(int id) async {
    Response res = await delete(Uri.parse("$postsUrl/$id"));

    if (res.statusCode == 200) {
      print("Deleted!");
    }
  }

  Future<List<Post>> getPosts() async {
    Response res = await get(Uri.parse(postsUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts =
          body.map((dynamic item) => Post.fromjson(item)).toList();

      return posts;
    } else {
      throw "Cant get posts";
    }
  }
}
