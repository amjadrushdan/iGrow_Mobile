// import 'dart:convert';

// import 'feed_model.dart';
// import 'package:http/http.dart' as http;

// Future<List<Feed>> fetchFeed() async {
//   final feedUrl = 'https://retoolapi.dev/Cb4x73/feed';
//   final response = await http.get(Uri.parse(feedUrl));

//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//     return jsonResponse.map((feed) => new Feed.fromJson(feed)).toList();
//   } else {
//     throw Exception('Failed to load feed from API');
//   }
// }

import 'dart:convert';
import 'feed_model.dart';
import 'package:http/http.dart' as http;

Future<List<Feed>> fetchFeed() async {
  final feedUrl = 'https://retoolapi.dev/Cb4x73/feed';
  final response = await http.get(Uri.parse(feedUrl));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((feed) => new Feed.fromJson(feed)).toList();
  } else {
    throw Exception('Failed to load feed from API');
  }
}

Future<Feed> createFeed(String title, String message) async {
  final response = await http.post(
    Uri.parse('https://retoolapi.dev/Cb4x73/feed'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'message': message,
    }),
  );

  if (response.statusCode == 201) {
    print('$title and $message');
    return Feed.fromJson(jsonDecode(response.body));
  } else {
    print('Failed');
    throw Exception('Failed to create Feed post.');
  }
}
