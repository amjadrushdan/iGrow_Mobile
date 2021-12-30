import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class InfoGroup extends StatefulWidget {
  final DocumentSnapshot docid;
  InfoGroup({required this.docid});

  @override
  State<InfoGroup> createState() => _InfoGroupState();
}

class _InfoGroupState extends State<InfoGroup> {
  String? user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.docid.get('name')),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      // actions
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Text("Join"),
        onPressed: () {
          widget.docid.reference.update({
            'joined_uid': FieldValue.arrayUnion([user]),
          }).whenComplete(() {
            Navigator.pop(context);
          });
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Group Name"),
                subtitle: Text(widget.docid.get('name')),
              ),
              ListTile(
                title: Text("Description"),
                subtitle: Text(widget.docid.get('about')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
