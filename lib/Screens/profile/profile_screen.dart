import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/edit_post.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: Icon(
          Icons.account_circle,
          color: Colors.grey,
          size: 40.0,
        ),
      ),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                          "${data.docs[index]['creator_id']}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18.0,
                                                          color: Colors.black),
                                                    ),
                                                  ]),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                flex: 5,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 4.0),
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit),
                                                    color: Colors.grey,
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    editPost(
                                                                      docid: snapshot
                                                                          .data!
                                                                          .docs[index],
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
                                            'https://img.purch.com/rc/1680x1050/aHR0cDovL3d3dy5zcGFjZS5jb20vaW1hZ2VzL2kvMDAwLzA0My8zMjgvb3JpZ2luYWwvYXJvdW5kLWEtc3Rhci1zeXN0ZW0tMTkyMC5qcGc='),
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
                } else {
                  print("${snapshot.error}");
                  // return Text("${snapshot.error}");
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
