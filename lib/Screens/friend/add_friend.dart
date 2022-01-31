import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/add_info_friend.dart';
import 'dart:async';

import 'package:flutter_auth/constants.dart';

class AddFriend extends StatefulWidget {
  @override
  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  String _foundedUsers = "";

  onSearch(String search) {
    setState(() {
      _foundedUsers = search;
      print(_foundedUsers);
    });
  }

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
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 38,
              margin: EdgeInsets.fromLTRB(15, 15, 15, 8),
              child: TextField(
                onChanged: (value) => onSearch(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black),
                    hintText: "Search users"),
              ),
            ),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: alluser,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: const CircularProgressIndicator(),
                    );
                  } else {
                    // return Text("Testing ...");
                    var data = snapshot.requireData;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
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
                              return SizedBox.shrink();
                            }
                            if (data.docs[index]['userid'] == user) {
                              return SizedBox.shrink();
                            }

                            var added = snapshot2
                                    .data!.docChanges[0].doc['friend_uid'] +
                                snapshot2
                                    .data!.docChanges[0].doc['pending_uid'] +
                                snapshot2
                                    .data!.docChanges[0].doc['request_uid'];
                            bool check =
                                added.contains(data.docs[index]['userid']);
                            bool check2 = "${data.docs[index]['username']}"
                                .toLowerCase()
                                .contains(_foundedUsers.toLowerCase());
                            if (!check && check2) {
                              return Card(
                                elevation: 6,
                                margin: EdgeInsets.all(10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 22,
                                    backgroundImage: NetworkImage(
                                        "${data.docs[index]['imageUrl']}"),
                                  ),
                                  title:
                                      Text("${data.docs[index]['username']}"),
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
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
