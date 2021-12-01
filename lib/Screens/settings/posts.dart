import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'booked_service.dart';
import 'post_detail.dart';
import 'post_model.dart';

class PostsPage extends StatelessWidget {
  final HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Booked Workshop"),
          backgroundColor: kPrimaryColor,
        ),
        body: FutureBuilder(
          future: httpService.getPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              List<Post>? posts = snapshot.data;

              return ListView(
                children: posts!
                    .map((Post post) => ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromRGBO(0, 0, 50, 0.5),
                                  width: 0.5),
                              borderRadius: BorderRadius.circular(5)),
                          minVerticalPadding: 10,
                          title: Text(post.programme_name),
                          subtitle: Text(post.date),
                          onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostDetail(
                              post: post,
                            ),
                          )),
                        ))
                    .toList(),
                padding: const EdgeInsets.all(12.0),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
