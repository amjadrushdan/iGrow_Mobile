import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_auth/Screens/group/info_group.dart';

class GroupDiscover extends StatefulWidget {
  @override
  _GroupDiscoverState createState() => _GroupDiscoverState();
}

class _GroupDiscoverState extends State<GroupDiscover> {
  final Stream<QuerySnapshot> group =
      FirebaseFirestore.instance.collection('group').snapshots();

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
              final data = snapshot.requireData;
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
}
