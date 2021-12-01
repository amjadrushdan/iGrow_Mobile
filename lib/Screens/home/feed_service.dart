import 'dart:convert';

import 'feed_model.dart';
import 'package:http/http.dart' as http;

Future<List<Feed>> fetchFeed() async {
  final feedUrl = 'https://retoolapi.dev/kzsh9b/feed';
  final response = await http.get(Uri.parse(feedUrl));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((feed) => new Feed.fromJson(feed)).toList();
  } else {
    throw Exception('Failed to load feed from API');
  }
}
