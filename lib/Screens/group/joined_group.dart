import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/feed_group.dart';

class GroupJoined extends StatefulWidget {
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
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
        stream: group,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                itemBuilder: (BuildContext context, int index) => Card(
                  elevation: 6,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.group,
                      size: 30,
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
                ),
              );
            }
          }
        },
      )),
    );
  }
}
