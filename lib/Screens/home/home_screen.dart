import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/home/post_page.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Home",
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
                if (snapshot.hasError) {
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
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
                                                                FontWeight.w600,
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
                    });
              })),
      floatingActionButton: FloatingActionButton(
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
    );
  }
}
