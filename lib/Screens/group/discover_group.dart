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
  String? user = FirebaseAuth.instance.currentUser?.uid;
  final Stream<QuerySnapshot> group =
      FirebaseFirestore.instance.collection('group').orderBy('id').snapshots();

  @override
  Widget build(BuildContext context) {
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
              data = checkIsJoin(data,user);
              return ListView.builder(
                itemCount: data.size,
                itemBuilder: (BuildContext context, int index) {
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
                                    docid: snapshot.data!.docs[index])));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  QuerySnapshot<Object?> checkIsJoin(QuerySnapshot<Object?> data,String? user){
    data.docs.remove(user);
    return data;
  }
}
