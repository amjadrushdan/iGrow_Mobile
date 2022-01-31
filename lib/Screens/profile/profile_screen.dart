import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/edit_post.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/service/appBar.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    late var user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> feed = FirebaseFirestore.instance
        .collection('feed')
        .orderBy('created_at')
        .where('creator_id', isEqualTo: user)
        .snapshots();
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: "Profile"),
      body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: feed,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
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
                                print(Text("Error data"));
                              }
                              if (snapshot2.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child:
                                      Image.asset('assets/images/loading.gif'),
                                );
                              }
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
                                          child: CachedNetworkImage(
                                            fadeInDuration:
                                                Duration(milliseconds: 500),
                                            imageUrl: snapshot2.data!
                                                .docChanges[0].doc['imageUrl'],
                                            placeholder: (context, url) =>
                                                const CircleAvatar(
                                              backgroundColor: kDeepGreen,
                                              radius: 27,
                                            ),
                                            imageBuilder: (context, image) =>
                                                CircleAvatar(
                                              backgroundImage: image,
                                              radius: 27,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                // padding: const EdgeInsets.only(
                                                //     top: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Container(
                                                          child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                            text:
                                                                "${snapshot2.data!.docChanges[0].doc['username']}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ]),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      )),
                                                      flex: 5,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 4.0),
                                                        child: IconButton(
                                                          icon:
                                                              Icon(Icons.edit),
                                                          color: Colors.grey,
                                                          onPressed: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          editPost(
                                                                            docid:
                                                                                snapshot.data!.docs[index],
                                                                          )),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      // flex: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                ),
                                                child: Text(
                                                  'Title: ' +
                                                      "${data.docs[index]['title']}" +
                                                      '\nㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤㅤ' +
                                                      "${data.docs[index]['message']}",
                                                  textAlign: TextAlign.start,
                                                  style:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                              ),
                                              data.docs[index]["imageUrl"] == ""
                                                  ? SizedBox.shrink()
                                                  : CachedNetworkImage(
                                                      placeholder: (context,
                                                              url) =>
                                                          Image(
                                                              image: AssetImage(
                                                                  'assets/images/loading.gif')),
                                                      imageUrl: data.docs[index]
                                                          ["imageUrl"],
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                      fadeInDuration: Duration(
                                                          milliseconds: 900),
                                                    )
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
                            });
                      });
                } else {
                  print("${snapshot.error}");
                  // return Text("${snapshot.error}");
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
