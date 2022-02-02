import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/friend/info_friend.dart';
import 'package:flutter_auth/Screens/home/post_page.dart';
import 'package:flutter_auth/service/appBar.dart';
import '../../constants.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Stream<QuerySnapshot> feed = FirebaseFirestore.instance
      .collection('feed')
      .orderBy('created_at')
      .where('group_id', isEqualTo: 0)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: "Home"),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: feed,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                  );
                }
                final data = snapshot.requireData;
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
                            return SizedBox.shrink();
                          }

                          var added =
                              snapshot2.data!.docChanges[0].doc['friend_uid'];
                          bool check = added.contains(user);
                          if (check || data.docs[index]['creator_id'] == user) {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6.0, 10.0, 10.0, 10.0),
                                        child: InkWell(
                                          child: CircleAvatar(
                                            radius: 27,
                                            backgroundImage: NetworkImage(
                                                snapshot2.data!.docChanges[0]
                                                        .doc['imageUrl'] ??
                                                    ""),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InfoFriend(
                                                          docid: snapshot2
                                                              .data!.docs[0]),
                                                ));
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18.0,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ]),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                                    flex: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                              child: Text(
                                                'Title: ' +
                                                    "${data.docs[index]['title']}" +
                                                    // '\n\n' +
                                                    '\nㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ' +
                                                    "${data.docs[index]['message']}",
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                              ),
                                            ),
                                            data.docs[index]["imageUrl"] == ""
                                                ? SizedBox.shrink()
                                                : CachedNetworkImage(
                                                    placeholder:
                                                        (context, url) => Image(
                                                            image: AssetImage(
                                                                'assets/images/loading.gif')),
                                                    imageUrl: data.docs[index]
                                                        ["imageUrl"],
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    fadeInDuration: Duration(
                                                        milliseconds: 900),
                                                  )

                                            // data.docs[index]["imageUrl"] == ""
                                            //     ? SizedBox.shrink()
                                            //     : FadeInImage.assetNetwork(
                                            //         fadeInDuration: Duration(
                                            //             milliseconds: 900),
                                            //         fadeInCurve:
                                            //             Curves.easeInCubic,
                                            //         placeholder:
                                            //             'assets/images/loading.gif',
                                            //         image: data.docs[index]
                                            //             ["imageUrl"],
                                            //       ),

                                            // data.docs[index]['imageUrl'] == ""
                                            //     ? SizedBox.shrink()
                                            //     : Image.network(
                                            //         "${data.docs[index]['imageUrl']}"),
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
                          } else {
                            return SizedBox.shrink();
                          }
                        },
                      );
                    });
              })),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Post()),
            );
          },
          backgroundColor: kPrimaryColor,
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
