import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'booked_service.dart';
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
        title: Text(post.programme_name),
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
                  title: Text("Speaker"),
                  subtitle: Text(post.speaker),
                ),
                ListTile(
                  title: Text("About"),
                  subtitle: Text(post.desc),
                ),
                ListTile(
                  title: Text("Start Time"),
                  subtitle: Text("${post.start_time}"),
                ),
                ListTile(
                  title: Text("End Time"),
                  subtitle: Text("${post.end_time}"),
                ),
                ListTile(
                  title: Text("Person In Charge"),
                  subtitle: Text("${post.pic}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
