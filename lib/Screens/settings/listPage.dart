import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/nav.dart';
import 'package:flutter_auth/constants.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //late Future _data;
  //Future getPosts() async {
  //var firestore = FirebaseFirestore.instance;

  //QuerySnapshot qn = await firestore.collection('workshop').get();
  //return qn.docs;

  //}

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .where(
          "joined_uid",
          arrayContains: user,
        )
        .snapshots();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            "Booked Workshop",
          ),
        ),
        body: Card(
          child: StreamBuilder<QuerySnapshot>(
            //future: getPosts(),
            stream: workshop,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //var indexLength = snapshot.data.length;
              if (!snapshot.hasData) {
                return Center(
                  child: Text("Loading..."),
                );
              } else {
                final data = snapshot.requireData;

                if (data.docs.isEmpty) {
                  return Text(
                    "You have not book any workshop !",
                    textScaleFactor: 1.3,
                  );
                } else {
                  //var data = snapshot.requireData;
                  //data = checkIsJoin(data, user);
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: data.size,
                      itemBuilder: (BuildContext context, int index) => Card(
                          elevation: 6,
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 22,
                              backgroundImage:
                                  NetworkImage(data.docs[index]['imageUrl']),
                            ),
                            //title: Text(snapshot.data[index]['programmename']),
                            //subtitle: Text(snapshot.data[index]['date']),
                            title: Text("${data.docs[index]['programmename']}"),
                            subtitle: Text("${data.docs[index]['date']}"),
                            //onTap: () => navigateToDetail(snapshot.data[index]),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                          post: snapshot.data!.docs[index],
                                        )),
                              );
                            },
                          )));
                }
              }
            },
          ),
        ));
  }

  QuerySnapshot<Object?> checkIsJoin(
      QuerySnapshot<Object?> data, String? user) {
    data.docs.remove(user);
    return data;
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({required this.post});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post["programmename"]),
        backgroundColor: kPrimaryColor,
      ),
      body: ListView(
        children: [
          Image.network(widget.post["imageUrl"]),
          ListTile(
            title: Text("Description"),
            subtitle: Text(widget.post["description"]),
          ),
          new Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Date"),
            subtitle: Text(widget.post["date"]),
          ),
          new Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Time"),
            subtitle:
                Text(widget.post["starttime"] + " - " + widget.post["endtime"]),
          ),
          new Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Person In Charge"),
            subtitle: Text(widget.post["PIC"]),
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text("Speaker"),
            subtitle: Text(widget.post["speaker"]),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kPrimaryColor,
        icon: Icon(Icons.delete),
        label: Text("Delete"),
        onPressed: () {
          //create group
          deleteJoin(context);
        },
      ),
    );
  }

  Future deleteJoined(context) async {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .doc('uid')
        .collection("join_workshop")
        .snapshots();

    //return await doc.delete();
  }

  void deleteJoin(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    Stream<QuerySnapshot> workshop = FirebaseFirestore.instance
        .collection('workshop')
        .doc('uid')
        .collection("join_workshop")
        .snapshots();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("Please confirm"),
            content: Text("Sure to cancel booking?"),
            actions: [
              TextButton(
                  onPressed: () {
                    widget.post.reference.update({
                      'joined_uid': FieldValue.arrayRemove([user]),
                    }).whenComplete(() => Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Nav())));
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
