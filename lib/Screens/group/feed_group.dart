import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/nav.dart';
import '../../constants.dart';
import 'post_group.dart';

class GroupFeed extends StatefulWidget {
  final DocumentSnapshot docid;
  GroupFeed({required this.docid});

  @override
  _GroupFeedState createState() => _GroupFeedState();
}

class _GroupFeedState extends State<GroupFeed> {
  String? user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    
    late var id = widget.docid.get('id');
    final Stream<QuerySnapshot> feed = FirebaseFirestore.instance
        .collection('feed')
        .orderBy('created_at')
        .where('group_id', isEqualTo: id)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Group Feed",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _alert(context);
              },
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: feed,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.requireData;
            if (data.docs.isEmpty) {
              return Text(
                "No post yet!",
                textScaleFactor: 1.3,
              );
            } else {
              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, int reverseindex) {
                  int index = data.size - 1 - reverseindex;

                  //edit here
                  final Stream<QuerySnapshot> username = FirebaseFirestore
                      .instance
                      .collection('member')
                      .where('userid',
                          isEqualTo: "${data.docs[index]['creator_id']}")
                      .snapshots();
                  return StreamBuilder(
                    stream: username,
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
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                    text:
                                                        "${snapshot2.data!.docChanges[0].doc['username']}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.0,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              flex: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Text(
                                          'Title: ' +
                                              "${data.docs[index]['title']}" +
                                              // '\n\n' +
                                              '\nㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ' +
                                              "${data.docs[index]['message']}",
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      Image.network(
                                          "${data.docs[index]['imageUrl']}"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.7,
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GroupPost(groupid: id)),
          );
        },
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
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
            title: Text('Please Confirm'),
            content: Text('Are you sure to leave group?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    widget.docid.reference.update({
                      'joined_uid': FieldValue.arrayRemove([user]),
                    }).whenComplete(() => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => Nav()),
                        ));
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}