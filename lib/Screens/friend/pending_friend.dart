import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/info_friend.dart';
import 'package:flutter_auth/Screens/nav.dart';

import '../../constants.dart';

class PendingFriend extends StatefulWidget {
  const PendingFriend({Key? key}) : super(key: key);

  @override
  State<PendingFriend> createState() => _PendingFriendState();
}

class _PendingFriendState extends State<PendingFriend> {
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
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Pending Friend Request",
        ),
      ),
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
                        return SizedBox.shrink();
                      }
                      if (data.docs[index]['userid'] == user) {
                        return SizedBox.shrink();
                      }

                      var added =
                          // snapshot2.data!.docChanges[0].doc['friend_uid'] +
                          snapshot2.data!.docChanges[0].doc['pending_uid'];
                      print(added);
                      bool check = added.contains(data.docs[index]['userid']);

                      if (!check) {
                        return SizedBox.shrink();
                      } else {
                        return Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading:  CachedNetworkImage(
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
                            // CircleAvatar(
                            //   radius: 22,
                            //   backgroundImage: NetworkImage(
                            //       "${data.docs[index]['imageUrl']}"),
                            // ),
                            title: Text("${data.docs[index]['username']}"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InfoFriend(
                                        docid: snapshot.data!.docs[index]),
                                  ));
                            },
                            trailing: Wrap(
                              spacing: 12, // space between two icons
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      snapshot.data!.docs[index].reference
                                          .update({
                                        'request_uid':
                                            FieldValue.arrayRemove([user]),
                                      }).whenComplete(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Nav()));
                                        // Navigator.pop(context);
                                      });
                                      snapshot.data!.docs[index].reference
                                          .update({
                                        'friend_uid':
                                            FieldValue.arrayUnion([user]),
                                      }).whenComplete(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Nav()));
                                        // Navigator.pop(context);
                                      });
                                      snapshot2.data!.docs[0].reference.update({
                                        'friend_uid': FieldValue.arrayUnion([
                                          snapshot.data!.docs[index]['userid']
                                        ]),
                                      }).whenComplete(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Nav()));
                                        // Navigator.pop(context);
                                      });
                                      snapshot2.data!.docs[0].reference.update({
                                        'pending_uid': FieldValue.arrayRemove([
                                          snapshot.data!.docs[index]['userid']
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
                                      Icons.check_circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 0.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      //reject friend pending
                                      snapshot.data!.docs[index].reference
                                          .update({
                                        'request_uid':
                                            FieldValue.arrayRemove([user]),
                                      }).whenComplete(() {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => Nav()));
                                        // Navigator.pop(context);
                                      });
                                      snapshot2.data!.docs[0].reference.update({
                                        'pending_uid': FieldValue.arrayRemove([
                                          snapshot.data!.docs[index]['userid']
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
