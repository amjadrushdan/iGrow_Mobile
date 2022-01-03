import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/add_info_friend.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/info_group.dart';

class AddFriend extends StatefulWidget {
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> friend = FirebaseFirestore.instance
        .collection('member')
        .where('userid', isEqualTo: user)
        // .orderBy('id')
        .snapshots();

    final Stream<QuerySnapshot> alluser =
        FirebaseFirestore.instance.collection('member').snapshots();

    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: alluser,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else {
              // return Text("Testing ...");
              var data = snapshot.requireData;

              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, int index) {
                  return StreamBuilder(
                    stream: friend,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot2) {
                      if (snapshot2.hasError) {
                        return Text("something is wrong");
                      }
                      if (snapshot2.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (data.docs[index]['userid'] == user) {
                        return SizedBox.shrink();
                      }

                      var added =
                          snapshot2.data!.docChanges[0].doc['friend_uid'] +
                              snapshot2.data!.docChanges[0].doc['pending_uid'] +
                              snapshot2.data!.docChanges[0].doc['request_uid'];
                      bool check = added.contains(data.docs[index]['userid']);

                      if (check) {
                        return SizedBox.shrink();
                      } else {
                        return Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: Icon(
                              Icons.group,
                              size: 30,
                            ),
                            title: Text("${data.docs[index]['username']}"),
                            trailing: Icon(Icons.add),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddInfoFriend(
                                        docid: snapshot.data!.docs[index],
                                        docuser: snapshot2.data!.docs[0]),
                                  ));
                            },
                          ),
                        );
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
