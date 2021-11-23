import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'http_service.dart';
import 'post_model.dart';

class PostDetail extends StatelessWidget {
  final Post post;
  final HttpService httpService = HttpService();
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');
  PostDetail({
    required this.post,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
        backgroundColor: kPrimaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(delete),
        onPressed: () async {
          await httpService.deletePost(post.id);
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Title"),
                  subtitle: Text(post.title),
                ),
                ListTile(
                  title: Text("Body"),
                  subtitle: Text(post.body),
                ),
                ListTile(
                  title: Text("User ID"),
                  subtitle: Text("${post.userId}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
