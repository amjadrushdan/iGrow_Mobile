import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/info_group.dart';

class GroupDiscover extends StatefulWidget {
  @override
  _GroupDiscoverState createState() => _GroupDiscoverState();
}

class _GroupDiscoverState extends State<GroupDiscover> {
  @override
  Widget build(BuildContext context) {
    String? user = FirebaseAuth.instance.currentUser?.uid;
    final Stream<QuerySnapshot> group = FirebaseFirestore.instance
        .collection('group')
        .orderBy('id')
        .snapshots();

    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: group,
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
                  var joined = data.docs[index]['joined_uid'];
                  bool check = joined.contains(user!);
                  if (!check) {
                    return Card(
                      elevation: 6,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Icon(
                          Icons.group,
                          size: 30,
                        ),
                        title: Text("${data.docs[index]['name']}"),
                        trailing: Icon(Icons.add),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InfoGroup(
                                    docid: snapshot.data!.docs[index]),
                              ));
                        },
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }

                  // } else
                  //   return SizedBox();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
