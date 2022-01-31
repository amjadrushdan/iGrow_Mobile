import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/feed_group.dart';
import 'package:flutter_auth/constants.dart';

class GroupJoined extends StatefulWidget {
  String FilterText;

  GroupJoined({required this.FilterText});
  @override
  _GroupJoinedState createState() => _GroupJoinedState();
}

class _GroupJoinedState extends State<GroupJoined> {
  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> group = FirebaseFirestore.instance
        .collection('group')
        .where(
          "joined_uid",
          arrayContains: user,
        )
        // .orderBy('id')
        .snapshots();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: group,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else {
              final data = snapshot.requireData;

              if (data.docs.isEmpty) {
                return Text(
                  "You have not join any group !",
                  textScaleFactor: 1.3,
                );
              } else {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data.size,
                  itemBuilder: (BuildContext context, int index) {
                   
                    // var joined = data.docs[index]['joined_uid'];
                    // bool check1 = joined.contains(user!);
                    var state = widget.FilterText;
                    bool check2 = state.contains(data.docs[index]['state']);
                    bool check3 = (widget.FilterText).isEmpty;
                    bool check4 = state.contains(data.docs[index]['soil']);

                    if ((check2 || check4) || check3) {
                      return Card(
                        elevation: 6,
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          leading:  CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 200),
                              imageUrl: data.docs[index]['imageUrl'],
                              placeholder: (context, url) => const CircleAvatar(
                                backgroundColor: kDeepGreen,
                                radius: 22,
                              ),
                              imageBuilder: (context, image) => CircleAvatar(
                                backgroundImage: image,
                                radius: 22,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          title: Text("${data.docs[index]['name']}"),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupFeed(
                                        docid: snapshot.data!.docs[index],
                                      )),
                            );
                          },
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
