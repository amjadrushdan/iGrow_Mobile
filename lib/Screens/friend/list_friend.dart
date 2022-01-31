import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_auth/Screens/friend/info_friend.dart';
import 'package:flutter_auth/constants.dart';

import '../nav.dart';

class ListFriend extends StatefulWidget {
  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
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

                            var added =
                                snapshot2.data!.docChanges[0].doc['friend_uid'];
                            // snapshot2.data!.docChanges[0].doc['pending_uid'];
                            bool check =
                                added.contains(data.docs[index]['userid']);
                            bool check2 = "${data.docs[index]['username']}"
                                .toLowerCase()
                                .contains(_foundedUsers.toLowerCase());

                            if (check && check2) {
                              return Card(
                                elevation: 6,
                                margin: EdgeInsets.all(10),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 500),
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
                                  title:
                                      Text("${data.docs[index]['username']}"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => InfoFriend(
                                              docid:
                                                  snapshot.data!.docs[index]),
                                        ));
                                  },
                                  trailing: Wrap(
                                    spacing: 12, // space between two icons
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(right: 0.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            //reject friend pending
                                            snapshot.data!.docs[index].reference
                                                .update({
                                              'friend_uid':
                                                  FieldValue.arrayRemove(
                                                      [user]),
                                            }).whenComplete(() {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => Nav()));
                                              // Navigator.pop(context);
                                            });
                                            snapshot2.data!.docs[0].reference
                                                .update({
                                              'friend_uid':
                                                  FieldValue.arrayRemove([
                                                snapshot.data!.docs[index]
                                                    ['userid']
                                              ]),
                                            }).whenComplete(() {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => Nav()));
                                              // Navigator.pop(context);
                                            });
                                          },
                                          child: Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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

  void _alert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('Incorrect Email/Password'),
          content: Text("Please retry"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  'Ok',
                  textScaleFactor: 1.5,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
